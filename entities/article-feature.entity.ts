import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Feature } from "./feature.entity";

@Index("uq_article_feature_article_id_feature_id", ["articleId", "featureId"], {
  unique: true,
})
@Index("fk_article_feature_feature_id", ["featureId"], {})
@Entity("article_feature")
export class ArticleFeature {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "article_feature_id",
    unsigned: true,
  })
  articleFeatureId: number;

  @Column("int", { name: "article_id", unsigned: true, default: () => "'0'" })
  articleId: number;

  @Column("int", { name: "feature_id", unsigned: true, default: () => "'0'" })
  featureId: number;

  @Column("varchar", { name: "value", length: 255, default: () => "'0'" })
  value: string;

  @ManyToOne(() => Feature, (feature) => feature.articleFeatures, {
    onDelete: "RESTRICT",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "feature_id", referencedColumnName: "featureId" }])
  feature: Feature;
}
