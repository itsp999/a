import { Controller, Post, Body, UnauthorizedException, BadRequestException } from '@nestjs/common';
import { AuthService } from './auth.service';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('register')
  async register(@Body() data: { email: string; username: string; password_hash: string }) {
    if (!data.email || !data.username || !data.password_hash) {
      throw new BadRequestException('All fields are required');
    }
    return await this.authService.register(data);
  }

  @Post('login')
  async login(@Body() data: { email: string; password_hash: string }) {
    if (!data.email || !data.password_hash) {
      throw new BadRequestException('Email and password are required');
    }
    return await this.authService.login(data);
  }
}
