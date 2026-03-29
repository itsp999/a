import { Controller, Get, Post, Body, Headers, Param } from '@nestjs/common';
import { ProductsService } from './products.service';
import { ProductType } from './product.entity';

@Controller('products')
export class ProductsController {
  constructor(private readonly productsService: ProductsService) {}

  @Get()
  async findAll(@Headers('accept-language') lang: string = 'en') {
    // Basic lang handling: take the first two letters (e.g., 'zh-CN' -> 'zh')
    const langCode = lang.split(',')[0].substring(0, 2);
    return await this.productsService.findAll(langCode);
  }

  @Post()
  async create(@Body() data: {
    type: ProductType;
    price: number;
    stock: number;
    brandName?: string;
    imageUrl: string;
    translations: { languageCode: string; name: string; description: string }[];
  }) {
    return await this.productsService.create(data);
  }

  @Get(':id')
  async findOne(@Param('id') id: string, @Headers('accept-language') lang: string = 'en') {
    const langCode = lang.split(',')[0].substring(0, 2);
    return await this.productsService.findOne(id, langCode);
  }
}
