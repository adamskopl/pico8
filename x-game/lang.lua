LANGS = {
  en = {
    PRESS_KEY = "press key",
    TITLE = "'get off my lawn'",
    PRESENTS = "presents",
    AUTHOR = "kurnik software",
    LEVEL_CLEARED = "LEVEL CLEARED!",
    EYES_CLEARED = function(n, total)
      return "EYES CLEARED: " .. n .. "/" .. total
    end,
    LEVEL_NUM = function(n)
      return "LEVEL " .. n
    end
    -- add more keys as needed
  },
  pl = {
    PRESS_KEY = "nacisnij klawisz",
    TITLE = "'wynocha z mego trawnika'",
    PRESENTS = "przedstawia",
    AUTHOR = "kurnik software",
    LEVEL_CLEARED = "POZIOM UKONCZONY!",
    EYES_CLEARED = function(n, total)
      return "USUNIĘTE oczy: " .. n .. "/" .. total
    end,
    LEVEL_NUM = function(n)
      return "POZIOM " .. n
    end
    -- add more keys as needed
  }
}

LANG = LANGS.pl -- default, switch to LANGS.pl for Polish
