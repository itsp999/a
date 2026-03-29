import { Injectable, UnauthorizedException, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from './user.entity';
import * as bcrypt from 'bcrypt';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(User)
    private userRepository: Repository<User>,
    private jwtService: JwtService,
  ) {}

  async register(data: { email: string; username: string; password_hash: string }) {
    const existing = await this.userRepository.findOne({ where: [{ email: data.email }, { username: data.username }] });
    if (existing) throw new BadRequestException('User already exists');

    const hashedPassword = await bcrypt.hash(data.password_hash, 10);
    const user = this.userRepository.create({ ...data, passwordHash: hashedPassword });
    await this.userRepository.save(user);
    
    return { status: 'success' };
  }

  async login(data: { email: string; password_hash: string }) {
    const user = await this.userRepository.findOne({ where: { email: data.email } });
    if (!user) throw new UnauthorizedException('Invalid credentials');

    const isMatch = await bcrypt.compare(data.password_hash, user.passwordHash);
    if (!isMatch) throw new UnauthorizedException('Invalid credentials');

    const payload = { sub: user.id, username: user.username, role: user.role };
    return {
      access_token: await this.jwtService.signAsync(payload),
      user: { id: user.id, username: user.username, role: user.role, lang: user.preferredLanguage },
    };
  }
}
