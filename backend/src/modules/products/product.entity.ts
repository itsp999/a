import { Entity, Column, PrimaryGeneratedColumn, ManyToOne, OneToMany } from 'typeorm';

export enum ProductType {
  C2C = 'C2C',
  B2C = 'B2C',
  SELF_OPERATED = 'SELF_OPERATED',
}

@Entity()
export class Product {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({
    type: 'enum',
    enum: ProductType,
    default: ProductType.C2C,
  })
  type: ProductType;

  @Column('decimal')
  price: number;

  @Column()
  stock: number;

  @Column({ nullable: true })
  brandName: string; // Used for B2C

  @Column()
  imageUrl: string;

  @OneToMany(() => ProductTranslation, (translation) => translation.product, { cascade: true })
  translations: ProductTranslation[];
}

@Entity()
export class ProductTranslation {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  languageCode: string; // 'en', 'zh', etc.

  @Column()
  name: string;

  @Column('text')
  description: string;

  @ManyToOne(() => Product, (product) => product.translations)
  product: Product;
}
