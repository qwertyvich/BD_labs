
CREATE TABLE branch (
    branch_id serial PRIMARY KEY,
    branch_code varchar(10) NOT NULL UNIQUE,
    city varchar(100) NOT NULL,
    address varchar(200) NOT NULL,
    UNIQUE (city, address)
);

CREATE TABLE client (
    client_id serial PRIMARY KEY,
    full_name varchar(150) NOT NULL,
    phone varchar(20) NOT NULL UNIQUE,
    email varchar(150) NOT NULL UNIQUE,
    registered_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE account (
    account_id serial PRIMARY KEY,
    account_number varchar(20) NOT NULL UNIQUE,
    client_id integer NOT NULL,
    branch_id integer NOT NULL,
    opened_on date NOT NULL DEFAULT CURRENT_DATE,
    status varchar(10) NOT NULL DEFAULT 'active',
    CHECK (length(account_number) = 20),
    CHECK (translate(account_number, '0123456789', '') = ''),
    CHECK (status IN ('active', 'inactive')),
    FOREIGN KEY (client_id) REFERENCES client(client_id) ON DELETE RESTRICT,
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE RESTRICT
);

CREATE TABLE bank_card (
    card_id serial PRIMARY KEY,
    card_number varchar(16) NOT NULL UNIQUE,
    account_id integer NOT NULL,
    issued_on date NOT NULL,
    expires_on date NOT NULL,
    CHECK (length(card_number) = 16),
    CHECK (translate(card_number, '0123456789', '') = ''), --TRANSLATE(строка, строка_поиска, строка_замены) // 
    CHECK (expires_on > issued_on),
    FOREIGN KEY (account_id) REFERENCES account(account_id) ON DELETE RESTRICT
);

CREATE TABLE transfer (
    transfer_id serial PRIMARY KEY,
    from_account_id integer NOT NULL,
    to_account_id integer NOT NULL,
    amount numeric(14, 2) NOT NULL,
    transferred_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK (amount > 0),
    CHECK (from_account_id <> to_account_id),
    FOREIGN KEY (from_account_id) REFERENCES account(account_id) ON DELETE RESTRICT,
    FOREIGN KEY (to_account_id) REFERENCES account(account_id) ON DELETE RESTRICT
);

CREATE TABLE loan (
    loan_id serial PRIMARY KEY,
    account_id integer NOT NULL,
    principal numeric(14, 2) NOT NULL, -- сумма кред
    annual_rate numeric(5, 2) NOT NULL, -- ставка%
    issued_on date NOT NULL, --  дв
    due_on date NOT NULL, --дп
    CHECK (principal > 0),
    CHECK (annual_rate >= 0),
    CHECK (due_on > issued_on),
    FOREIGN KEY (account_id) REFERENCES account(account_id) ON DELETE RESTRICT
);
