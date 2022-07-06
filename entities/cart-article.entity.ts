import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Cart } from "./cart.entity";
import { Article } from "./article.entiyt";

@Index("uq_cart_article_cart_id_article_id", ["cartId", "articleId"], {
  unique: true,
})
@Index("fk_cart_article_article_id", ["articleId"], {})
@Entity("cart_article")
export class CartArticle {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "cart_article_id",
    unsigned: true,
  })
  cartArticleId: number;

  @Column("int", { name: "cart_id", unsigned: true, default: () => "'0'" })
  cartId: number;

  @Column("int", { name: "article_id", unsigned: true, default: () => "'0'" })
  articleId: number;

  @Column("int", { name: "quantity", unsigned: true, default: () => "'0'" })
  quantity: number;

  @ManyToOne(() => Cart, (cart) => cart.cartArticles, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "cart_id", referencedColumnName: "cartId" }])
  cart: Cart;

  @ManyToOne(() => Article, (article) => article.cartArticles, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "article_id", referencedColumnName: "articleId" }])
  article: Article;
}
