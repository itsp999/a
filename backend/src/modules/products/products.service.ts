import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Product, ProductTranslation, ProductType } from './product.entity';

@Injectable()
export class ProductsService {
  constructor(
    @InjectRepository(Product)
    private productRepository: Repository<Product>,
    @InjectRepository(ProductTranslation)
    private translationRepository: Repository<ProductTranslation>,
  ) {}

  // Find all products with a specific language filter
  async findAll(lang: string = 'en') {
    const products = await this.productRepository.find({
      relations: ['translations'],
    });

    return products.map((p) => {
      // Find translation for the requested language or default to first
      const translation = p.translations.find((t) => t.languageCode === lang) || p.translations[0];
      return {
        ...p,
        name: translation.name,
        description: translation.description,
        translations: undefined, // Hide raw translations
      };
    });
  }

  // Create a product with multiple translations
  async create(data: {
    type: ProductType;
    price: number;
    stock: number;
    brandName?: string;
    imageUrl: string;
    translations: { languageCode: string; name: string; description: string }[];
  }) {
    const product = this.productRepository.create(data);
    return await this.productRepository.save(product);
  }

  async findOne(id: string, lang: string = 'en') {
    const product = await this.productRepository.findOne({
      where: { id },
      relations: ['translations'],
    });
    if (!product) throw new NotFoundException();

    const translation = product.translations.find((t) => t.languageCode === lang) || product.translations[0];
    return {
      ...product,
      name: translation.name,
      description: translation.description,
    };
  }
}
