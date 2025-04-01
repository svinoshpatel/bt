-- main.lua - Головний скрипт для тестування бінарного дерева

local tree = require("tree")

-- Функція для виведення меню
local function printMenu()
    print("\nМеню:")
    print("1. Створити нове дерево")
    print("2. Показати дерево")
    print("3. Обхід у прямому порядку (Pre-order)")
    print("4. Обхід у зворотному порядку (Post-order)")
    print("5. Обхід у внутрішньому порядку (In-order)")
    print("6. Вийти")
    print("Виберіть опцію: ")
end

-- Основна функція
local function main()
    local root = nil
    local choice = 0
    
    while true do
        printMenu()
        choice = tonumber(io.read())
        
        if choice == 1 then
            print("Введіть кількість вузлів у дереві: ")
            local n = tonumber(io.read())
            if n and n > 0 then
                root = tree.createtree(n)
                print("Дерево успішно створено!")
            else
                print("Невірна кількість вузлів!")
            end
        elseif choice == 2 then
            if root then
                print("Структура дерева:")
                tree.showtree(root)
            else
                print("Дерево не створене!")
            end
        elseif choice == 3 then
            if root then
                print("Обхід у прямому порядку:")
                tree.preOrder(root)
            else
                print("Дерево не створене!")
            end
        elseif choice == 4 then
            if root then
                print("Обхід у зворотному порядку:")
                tree.postOrder(root)
            else
                print("Дерево не створене!")
            end
        elseif choice == 5 then
            if root then
                print("Обхід у внутрішньому порядку:")
                tree.inOrder(root)
            else
                print("Дерево не створене!")
            end
        elseif choice == 6 then
            print("Вихід...")
            break
        else
            print("Невірний вибір! Спробуйте ще раз.")
        end
    end
end

-- Запуск програми
main()
