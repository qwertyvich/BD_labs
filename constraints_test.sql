
INSERT INTO branch (branch_code, city, address)
VALUES ('MSK-NEW', 'Moscow', 'Tverskaya Street, 7');

INSERT INTO client (full_name, phone, email)
VALUES ('Ilya Sokolov', '+79001110005', 'anna@gmail.com');

INSERT INTO account (account_number, client_id, branch_id)
VALUES ('40817810000000000007', 9999, 1);

INSERT INTO account (account_number, client_id, branch_id)
VALUES ('4081781000000000000X', 1, 1);

INSERT INTO bank_card (card_number, account_id, issued_on, expires_on)
VALUES ('4276000000000006', 1, '2026-05-01', '2025-05-01');

INSERT INTO transfer (from_account_id, to_account_id, amount)
VALUES (1, 2, -100.00);

INSERT INTO transfer (from_account_id, to_account_id, amount)
VALUES (1, 1, 50.00);

UPDATE loan SET annual_rate = -1 WHERE loan_id = 1;

UPDATE account SET status = 'blocked' WHERE account_id = 1;
