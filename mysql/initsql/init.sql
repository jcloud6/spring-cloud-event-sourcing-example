USE dev

DROP TABLE IF EXISTS account_addresses;
DROP TABLE IF EXISTS account_credit_cards;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS account;

CREATE TABLE account
(
  id              BIGINT(20) PRIMARY KEY NOT NULL,
  created_at      BIGINT(20),
  last_modified   BIGINT(20),
  account_number  VARCHAR(255),
  default_account BIT(1),
  user_id         VARCHAR(255)
);

DROP TABLE IF EXISTS address;

CREATE TABLE address
(
  id            BIGINT(20) PRIMARY KEY NOT NULL,
  created_at    BIGINT(20),
  last_modified BIGINT(20),
  address_type  INT(11),
  city          VARCHAR(255),
  country       VARCHAR(255),
  state         VARCHAR(255),
  street1       VARCHAR(255),
  street2       VARCHAR(255),
  zip_code      INT(11)
);

DROP TABLE IF EXISTS credit_card;

CREATE TABLE credit_card
(
  id            BIGINT(20) PRIMARY KEY NOT NULL,
  created_at    BIGINT(20),
  last_modified BIGINT(20),
  number        VARCHAR(255),
  type          INT(11)
);

CREATE TABLE customer
(
  id            BIGINT(20) PRIMARY KEY NOT NULL,
  created_at    BIGINT(20),
  last_modified BIGINT(20),
  email         VARCHAR(255),
  first_name    VARCHAR(255),
  last_name     VARCHAR(255),
  account_id    BIGINT(20),
  CONSTRAINT FK_jwt2qo9oj3wd7ribjkymryp8s FOREIGN KEY (account_id) REFERENCES account (id)
);
CREATE INDEX UK_jwt2qo9oj3wd7ribjkymryp8s ON customer (account_id);

CREATE TABLE account_addresses
(
  account_id   BIGINT(20) NOT NULL,
  addresses_id BIGINT(20) NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (account_id, addresses_id),
  CONSTRAINT FK_12vtt2maaj4yfrkbjmkf2qonq FOREIGN KEY (account_id) REFERENCES account (id),
  CONSTRAINT FK_r2ahplt2rqwvx1pnd5bbo7o70 FOREIGN KEY (addresses_id) REFERENCES address (id)
);
CREATE UNIQUE INDEX UK_r2ahplt2rqwvx1pnd5bbo7o70 ON account_addresses (addresses_id);

CREATE TABLE account_credit_cards
(
  account_id      BIGINT(20) NOT NULL,
  credit_cards_id BIGINT(20) NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (account_id, credit_cards_id),
  CONSTRAINT FK_b0tk2gq9bk6cggk5c4d33g3y4 FOREIGN KEY (credit_cards_id) REFERENCES credit_card (id),
  CONSTRAINT FK_lb5lhjdqfk50esr5g5733ppdo FOREIGN KEY (account_id) REFERENCES account (id)
);
CREATE UNIQUE INDEX UK_b0tk2gq9bk6cggk5c4d33g3y4 ON account_credit_cards (credit_cards_id);


DELETE FROM customer;
DELETE FROM account_addresses;
DELETE FROM account_credit_cards;
DELETE FROM credit_card;
DELETE FROM account;
DELETE FROM address;
INSERT INTO account VALUES (0, unix_timestamp(now()), unix_timestamp(now()), 12345, 1, 'user');
SET @account_id = LAST_INSERT_ID();
INSERT INTO address VALUES (0, unix_timestamp(now()), unix_timestamp(now()), 0, 'Palo Alto', 'United States', 'CA', '3495 Deer Creek Road', '', '94304');
SET @address_id = LAST_INSERT_ID();
INSERT INTO account_addresses VALUES (@account_id, @address_id);
INSERT INTO credit_card VALUES (0, unix_timestamp(now()), unix_timestamp(now()), '1234567801234567', 0);
SET @cc_id = LAST_INSERT_ID();
INSERT INTO account_credit_cards VALUES (@account_id, @cc_id);
INSERT INTO customer VALUES (0, unix_timestamp(now()), unix_timestamp(now()), 'john.doe@example.com', 'John', 'Doe', @account_id);


DROP TABLE IF EXISTS catalog_info;
CREATE TABLE catalog_info
(
  id         VARCHAR(255) PRIMARY KEY NOT NULL,
  active     BIT(1),
  catalog_id BIGINT(20)
);



DELETE FROM catalog_info;
INSERT INTO catalog_info VALUES (0, 1, 0);



DROP TABLE IF EXISTS cart_event;
CREATE TABLE cart_event
(
  id              BIGINT(20) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  created_at      BIGINT(20),
  last_modified   BIGINT(20),
  cart_event_type INT(11),
  product_id      VARCHAR(255),
  quantity        INT(11),
  user_id         BIGINT(20)
);
CREATE INDEX IDX_CART_EVENT_USER ON cart_event (id, user_id);
ALTER TABLE cart_event AUTO_INCREMENT 0;
CREATE UNIQUE INDEX cart_event_id_uindex ON cart_event (id);



DROP TABLE IF EXISTS user;
CREATE TABLE user
(
  id            BIGINT(20) PRIMARY KEY NOT NULL,
  created_at    BIGINT(40),
  last_modified BIGINT(40),
  email         VARCHAR(255),
  first_name    VARCHAR(255),
  last_name     VARCHAR(255),
  username      VARCHAR(255)
);


DELETE FROM user;
INSERT INTO user VALUES (0, unix_timestamp(now()), unix_timestamp(now()), 'john.doe@example.com', 'John', 'Doe', 'user');