import { Column, Entity, Index, JoinColumn, OneToOne } from "typeorm";
import { Cart } from "./cart.entity";

@Index("uq_order_cart_id", ["cartId"], { unique: true })
@Entity("order")
export class Order {
  @Column("int", { primary: true, name: "order_id", unsigned: true })
  orderId: number;

  @Column("timestamp", {
    name: "created_at",
    default: () => "CURRENT_TIMESTAMP",
  })
  createdAt: Date;

  @Column("int", {
    name: "cart_id",
    unique: true,
    unsigned: true,
    default: () => "'0'",
  })
  cartId: number;

  @Column("enum", {
    name: "status",
    nullable: true,
    enum: ["rejected", "accepted", "shipped", "pending"],
    default: () => "'pending'",
  })
  status: "rejected" | "accepted" | "shipped" | "pending" | null;

  @OneToOne(() => Cart, (cart) => cart.order, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "cart_id", referencedColumnName: "cartId" }])
  cart: Cart;
}
