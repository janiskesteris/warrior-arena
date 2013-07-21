Warrior Arena
=============

```ruby
require_relative "battle_arena"

warrior_count = 2

battlefield = Battlefield.new(warrior_count)
battlefield.fight_to_death
battlefield.spectate
```

    Superman(500) dealt 54pts of damage to Batman(446)
    Batman(446) dealt 48pts of damage to Superman(452)
    Superman(452) dealt 54pts of damage to Batman(393)
    Batman(393) dealt 46pts of damage to Superman(406)
    Superman(406) dealt 54pts of damage to Batman(339)
    Batman(339) dealt 51pts of damage to Superman(355)
    Superman(355) dealt 54pts of damage to Batman(285)
    CRITICAL HIT
    Batman(285) dealt 97pts of damage to Superman(259)
    Superman(259) dealt 56pts of damage to Batman(229)
    Batman(229) dealt 52pts of damage to Superman(207)
    Superman(207) dealt 54pts of damage to Batman(176)
    Batman(176) dealt 49pts of damage to Superman(158)
    Superman(158) dealt 54pts of damage to Batman(122)
    CRITICAL HIT
    Superman(158) dealt 99pts of damage to Batman(23)
    Batman(23) dealt 51pts of damage to Superman(107)
    Superman(107) dealt 56pts of damage to Batman(-33)
    Superman(107) killed Batman(-33)
    The winner is Superman(107)
