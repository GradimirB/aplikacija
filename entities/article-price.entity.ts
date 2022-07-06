import { Column, Entity, Index, PrimaryGeneratedColumn } from "typeorm";

@Index("fk_article_price_article_id", ["articleId"], {})
@Entity("article_price", { schema: "aplikacija" })
export class ArticlePrice {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "article_price_id",
    unsigned: true,
  })
  articlePriceId: number;

  @Column("int", { name: "article_id", unsigned: true, default: () => "'0'" })
  articleId: number;

  @Column("decimal", {
    name: "price",
    unsigned: true,
    precision: 10,
    scale: 2,
    default: () => "'0.00'",
  })
  price: number;

  @Column("timestamp", {
    name: "created_at",
    default: () => "CURRENT_TIMESTAMP",
  })
  createdAt: Date;
}
