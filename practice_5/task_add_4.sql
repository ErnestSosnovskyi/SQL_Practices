-- 4. Показати активні контракти, де дата завершення EndDate ще не настала
-- (Враховуємо контракти, де дата завершення в майбутньому АБО контракт безстроковий - NULL)
SELECT ContractID, ContractType, StartDate, EndDate
FROM contracts
WHERE (EndDate IS NULL OR EndDate >= CURDATE())
ORDER BY StartDate DESC;