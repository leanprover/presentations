open list

check list     -- Type u_1 → Type u_1

check @cons    -- Π {A : Type u_1}, A → list A → list A
check @nil     -- Π {A : Type u_1}, list A
check @head    -- Π {A : Type u_1} [_inst_1 : inhabited A], list A → A
check @tail    -- Π {A : Type u_1}, list A → list A
check @append  -- Π {A : Type u_1}, list A → list A → list A
