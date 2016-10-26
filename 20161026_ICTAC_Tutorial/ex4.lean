constants A B : Type
constant F : Type → Type
constant G : Type → Type → Type

check A        -- Type
check F A      -- Type
check F nat    -- Type
check G A      -- Type → Type
check G A B    -- Type
check G A nat  -- Type
