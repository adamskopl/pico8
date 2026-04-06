DBG = {
  WALLS1 = {},
  WALLS2 = {}
}

function DBG.drawWalls1()
  for w in all(DBG.WALLS1) do
    rect(w.x, w.y, w.x + 8, w.y + 8, CFG.COLORS.RED)
  end
end

function DBG.drawWalls2()
  for w in all(DBG.WALLS2) do
    rect(w.x, w.y, w.x + 8, w.y + 8, CFG.COLORS.GREEN)
  end
end
