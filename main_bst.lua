-- main_bst.lua - Головний скрипт для тестування BST

local tree = require("tree")

-- Функція для виведення меню
local function printMenu()
    print("\nМеню BST:")
    print("1. Створити корінь BST")
    print("2. Вставити вузол")
    print("3. Видалити вузол")
    print("4. Пошук вузла")
    print("5. Знайти наступника (successor)")
    print("6. Знайти попередника (predecessor)")
    print("7. Показати дерево")
    print("8. Обхід у прямому порядку (Pre-order)")
    print("9. Обхід у зворотному порядку (Post-order)")
    print("10. Обхід у внутрішньому порядку (In-order)")
    print("11. Вийти")
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
            print("Введіть ключ кореневого вузла: ")
            local key = tonumber(io.read())
            if key then
                root = tree.createRootBST(key)
                print("Корінь BST успішно створено!")
            else
                print("Невірний ключ!")
            end
        elseif choice == 2 then
            if not root then
                print("Спочатку створіть корінь дерева!")
            else
                print("Введіть ключ для вставки: ")
                local key = tonumber(io.read())
                if key then
                    root = tree.insertNodeBST(root, key)
                    print("Вузол додано!")
                    tree.showtree(root)
                else
                    print("Невірний ключ!")
                end
            end
        elseif choice == 3 then
            if not root then
                print("Дерево порожнє!")
            else
                print("Введіть ключ для видалення: ")
                local key = tonumber(io.read())
                if key then
                    root = tree.deleteNodeBST(root, key)
                    print("Вузол видалено (якщо він існував)!")
                    tree.showtree(root)
                else
                    print("Невірний ключ!")
                end
            end
        elseif choice == 4 then
            if not root then
                print("Дерево порожнє!")
            else
                print("Введіть ключ для пошуку: ")
                local key = tonumber(io.read())
                if key then
                    local node = tree.searchNodeBST(root, key)
                    if node then
                        print("Вузол з ключем " .. key .. " знайдено!")
                    else
                        print("Вузол з ключем " .. key .. " не знайдено!")
                    end
                else
                    print("Невірний ключ!")
                end
            end
        elseif choice == 5 then
            if not root then
                print("Дерево порожнє!")
            else
                print("Введіть ключ вузла для пошуку наступника: ")
                local key = tonumber(io.read())
                if key then
                    local node = tree.searchNodeBST(root, key)
                    if node then
                        local successor = tree.successorNodeBST(node)
                        if successor then
                            print("Наступник вузла " .. key .. ": " .. successor.key)
                        else
                            print("Вузол " .. key .. " не має наступника!")
                        end
                    else
                        print("Вузол з ключем " .. key .. " не знайдено!")
                    end
                else
                    print("Невірний ключ!")
                end
            end
        elseif choice == 6 then
            if not root then
                print("Дерево порожнє!")
            else
                print("Введіть ключ вузла для пошуку попередника: ")
                local key = tonumber(io.read())
                if key then
                    local node = tree.searchNodeBST(root, key)
                    if node then
                        local predecessor = tree.predecessorNodeBST(node)
                        if predecessor then
                            print("Попередник вузла " .. key .. ": " .. predecessor.key)
                        else
                            print("Вузол " .. key .. " не має попередника!")
                        end
                    else
                        print("Вузол з ключем " .. key .. " не знайдено!")
                    end
                else
                    print("Невірний ключ!")
                end
            end
        elseif choice == 7 then
            if root then
                print("Структура дерева BST:")
                tree.showtree(root)
            else
                print("Дерево не створене!")
            end
        elseif choice == 8 then
            if root then
                print("Обхід у прямому порядку:")
                tree.preOrder(root)
            else
                print("Дерево не створене!")
            end
        elseif choice == 9 then
            if root then
                print("Обхід у зворотному порядку:")
                tree.postOrder(root)
            else
                print("Дерево не створене!")
            end
        elseif choice == 10 then
            if root then
                print("Обхід у внутрішньому порядку:")
                tree.inOrder(root)
            else
                print("Дерево не створене!")
            end
        elseif choice == 11 then
            print("Вихід...")
            break
        else
            print("Невірний вибір! Спробуйте ще раз.")
        end
    end
end

-- Запуск програми
main()
