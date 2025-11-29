LANGS = {
  en = {
    PRESS_KEY = "press key",
    TITLE = "'get off my lawn'",
    PRESENTS = "presents",
    AUTHOR = "kurnik software",
    LEVEL_CLEARED = "lawn cleared!",
    EYES_CLEARED = function(n, total)
      return "eyes cleared: " .. n .. "/" .. total
    end,
    LEVEL_NUM = function(n)
      return "level " .. n
    end
    -- add more keys as needed
  },
  pl = {
    PRESS_KEY = "nacisnij klawisz",
    TITLE = "'wynocha z mego trawnika'",
    PRESENTS = "przedstawia",
    AUTHOR = "kurnik software",
    LEVEL_CLEARED = "trawnik ukonczony!",
    EYES_CLEARED = function(n, total)
      return "usuniete oczy: " .. n .. "/" .. total
    end,
    LEVEL_NUM = function(n)
      return "poziom " .. n
    end
    -- add more keys as needed
  }
}

LANG = LANGS.pl -- default, switch to LANGS.pl for Polish
