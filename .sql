CREATE TABLE "users" (
  "user_id" UUID PRIMARY KEY DEFAULT 'gen_random_uuid()',
  "first_name" varchar(100) NOT NULL,
  "last_name" varchar(100) NOT NULL,
  "Phone" varchar(5) NOT NULL,
  "address" text NOT NULL,
  "email" varchar(255) UNIQUE NOT NULL,
  "password" varchar(100) NOT NULL,
  "is_prime_member" BOOLEAN DEFAULT false,
  "membership_expiry" TIMESTAMP,
  "is_blocked" BOOLEAN DEFAULT false,
  "created_at" timestamp,
  "updated_at" TIMESTAMP DEFAULT 'CURRENT_TIMESTAMP'
);

CREATE TABLE "admin" (
  "admin_id" UUID PRIMARY KEY DEFAULT 'gen_random_uuid()',
  "email" varchar(255) UNIQUE NOT NULL,
  "password" varchar(100) NOT NULL
);

CREATE TABLE "material" (
  "material_id" UUID PRIMARY KEY DEFAULT 'gen_random_uuid()',
  "name" varchar(100) NOT NULL,
  "type" varchar(100) NOT NULL,
  "dimentions" varchar(100),
  "price_per_units" decimal(10,2) NOT NULL,
  "created_at" timestamp
);

CREATE TABLE "orders" (
  "order_id" UUID PRIMARY KEY DEFAULT 'gen_random_uuid()',
  "user_id" UUID NOT NULL,
  "materi_id" UUID NOT NULL,
  "quanity" int NOT NULL,
  "price" decimal(10,2) NOT NULL,
  "total_price" decimal(10,2) NOT NULL,
  "status" varchar(100) DEFAULT 'pending',
  "created_at" timestamp,
  "updated_at" TIMESTAMP DEFAULT 'CURRENT_TIMESTAMP'
);

CREATE TABLE "cutting_result" (
  "cut_id" UUID PRIMARY KEY DEFAULT 'gen_random_uuid()',
  "order_id" UUID NOT NULL,
  "algorithm" text NOT NULL,
  "waste_piecse" decimal(10,2) NOT NULL,
  "cutting_duration" decimal(10,2) NOT NULL,
  "created_at" timestamp,
  "updated_at" TIMESTAMP DEFAULT 'CURRENT_TIMESTAMP'
);

CREATE TABLE "payment" (
  "payment_id" UUID PRIMARY KEY DEFAULT 'gen_random_uuid()',
  "order_id" UUID NOT NULL,
  "payment_method" varchar(255),
  "amount" decimal(10,2) NOT NULL,
  "status" varchar(255),
  "created_at" timestamp
);

CREATE TABLE "invoice" (
  "invoice_id" UUID PRIMARY KEY DEFAULT 'gen_random_uuid()',
  "payment_id" UUID NOT NULL,
  "order_id" UUID NOT NULL,
  "invoice_date" timestamp,
  "amount" decimal(10,2) NOT NULL
);

CREATE TABLE "chat" (
  "chat_id" UUID PRIMARY KEY DEFAULT 'gen_random_uuid()',
  "user_id" UUID NOT NULL,
  "admin_id" UUID NOT NULL,
  "message" text NOT NULL,
  "sent_at" timestamp
);

CREATE TABLE "notification" (
  "notification_id" UUID PRIMARY KEY DEFAULT 'gen_random_uuid()',
  "user_id" UUID NOT NULL,
  "message" text NOT NULL,
  "isRead" boolen,
  "created_at" timestamp
);

COMMENT ON COLUMN "material"."dimentions" IS 'Width, length, height';

COMMENT ON COLUMN "orders"."status" IS 'pending, processing, completed, cancelled';

COMMENT ON COLUMN "payment"."payment_method" IS 'Cash,UPI,Bank Transfer';

COMMENT ON COLUMN "payment"."status" IS 'successful ,failed';

ALTER TABLE "orders" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "orders" ADD FOREIGN KEY ("materi_id") REFERENCES "material" ("material_id");

ALTER TABLE "cutting_result" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("order_id");

ALTER TABLE "payment" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("order_id");

ALTER TABLE "invoice" ADD FOREIGN KEY ("payment_id") REFERENCES "payment" ("payment_id");

ALTER TABLE "invoice" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("order_id");

ALTER TABLE "chat" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "chat" ADD FOREIGN KEY ("admin_id") REFERENCES "admin" ("admin_id");

ALTER TABLE "notification" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");