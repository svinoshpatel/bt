-- tree.lua - Бібліотека для роботи з бінарними деревами

local tree = {}

-- Оголошення типу даних для вузла дерева
-- tree.datatype = "number" -- Можна змінити на інший тип за потребою

-- Структура вузла дерева
local Node = {
    key = nil,      -- ключ вузла
    parent = nil,   -- батьківський вузол
    left = nil,     -- лівий нащадок
    right = nil     -- правий нащадок
}

-- Функція для створення нового вузла
local function createNode(key, parent)
    local newNode = {
        key = key,
        parent = parent,
        left = nil,
        right = nil
    }
    return newNode
end

-- Рекурсивна функція для створення симетричного бінарного дерева
function tree.createtree(n)
    local function createSubtree(n)
        if n == 0 then
            return nil
        end
        
        -- Створюємо новий вузол (ключ генерується автоматично)
        local node = createNode(math.random(1, 100), nil)
        
        -- Розподіляємо вузли між лівим і правим піддеревом
        local n_left = math.floor(n / 2)
        local n_right = n - n_left - 1
        
        -- Рекурсивно створюємо піддерева
        node.left = createSubtree(n_left)
        if node.left then
            node.left.parent = node
        end
        
        node.right = createSubtree(n_right)
        if node.right then
            node.right.parent = node
        end
        
        return node
    end
    
    return createSubtree(n)
end

-- Функція для відображення дерева
function tree.showtree(root)
    local function showSubtree(node, level)
        if not node then return end
        
        -- Рекурсивно виводимо ліве піддерево
        showSubtree(node.left, level + 1)
        
        -- Виводимо поточний вузол з відступами
        local indent = string.rep("    ", level)
        print(indent .. node.key)
        
        -- Рекурсивно виводимо праве піддерево
        showSubtree(node.right, level + 1)
    end
    
    showSubtree(root, 0)
end

-- Функція для обходу дерева у прямому порядку (Pre-order)
function tree.preOrder(root)
    if not root then return end
    
    print(root.key)                 -- Обробляємо поточний вузол
    tree.preOrder(root.left)        -- Рекурсивно обходимо ліве піддерево
    tree.preOrder(root.right)       -- Рекурсивно обходимо праве піддерево
end

-- Функція для обходу дерева у зворотному порядку (Post-order)
function tree.postOrder(root)
    if not root then return end
    
    tree.postOrder(root.left)       -- Рекурсивно обходимо ліве піддерево
    tree.postOrder(root.right)      -- Рекурсивно обходимо праве піддерево
    print(root.key)                 -- Обробляємо поточний вузол
end

-- Функція для обходу дерева у внутрішньому порядку (In-order)
function tree.inOrder(root)
    if not root then return end
    
    tree.inOrder(root.left)         -- Рекурсивно обходимо ліве піддерево
    print(root.key)                 -- Обробляємо поточний вузол
    tree.inOrder(root.right)        -- Рекурсивно обходимо праве піддерево
end

-- Пошук вузла за ключем
function tree.searchNodeBST(root, key)
    local node = root
    while node do
        if key == node.key then
            return node
        elseif key < node.key then
            node = node.left
        else
            node = node.right
        end
    end
    return nil
end

-- Створення кореня BST
function tree.createRootBST(key)
    return createNode(key, nil)
end

-- Вставка нового вузла в BST
function tree.insertNodeBST(root, key)
    local newNode = createNode(key, nil)
    
    if not root then
        return newNode
    end
    
    local current = root
    local parent = nil
    
    while current do
        parent = current
        if key < current.key then
            current = current.left
        elseif key > current.key then
            current = current.right
        else
            print("Вузол з ключем " .. key .. " вже існує!")
            return root
        end
    end
    
    newNode.parent = parent
    if key < parent.key then
        parent.left = newNode
    else
        parent.right = newNode
    end
    
    return root
end

-- Пошук мінімального вузла у піддереві
local function findMinimum(node)
    while node and node.left do
        node = node.left
    end
    return node
end

-- Пошук максимального вузла у піддереві
local function findMaximum(node)
    while node and node.right do
        node = node.right
    end
    return node
end

-- Пошук наступника (successor)
function tree.successorNodeBST(node)
    if not node then return nil end
    
    if node.right then
        return findMinimum(node.right)
    end
    
    local parent = node.parent
    while parent and node == parent.right do
        node = parent
        parent = parent.parent
    end
    return parent
end

-- Пошук попередника (predecessor)
function tree.predecessorNodeBST(node)
    if not node then return nil end
    
    if node.left then
        return findMaximum(node.left)
    end
    
    local parent = node.parent
    while parent and node == parent.left do
        node = parent
        parent = parent.parent
    end
    return parent
end

-- Видалення вузла з BST
function tree.deleteNodeBST(root, key)
    local function deleteNode(node, key)
        if not node then return nil end
        
        if key < node.key then
            node.left = deleteNode(node.left, key)
        elseif key > node.key then
            node.right = deleteNode(node.right, key)
        else
            -- Вузол знайдено, видаляємо його
            if not node.left then
                local temp = node.right
                if temp then temp.parent = node.parent end
                return temp
            elseif not node.right then
                local temp = node.left
                if temp then temp.parent = node.parent end
                return temp
            end
            
            -- Вузол має двох нащадків
            local temp = findMinimum(node.right)
            node.key = temp.key
            node.right = deleteNode(node.right, temp.key)
        end
        return node
    end
    
    return deleteNode(root, key)
end

return tree
