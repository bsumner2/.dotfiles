function ToHexStr(r, g, b)
    if r > 255 or r < 0 or
       g > 255 or g < 0 or
       b > 255 or b < 0 then
        return "#000000"
    end
    return string.format("#%02X%02X%02X", r, g, b)
end

function CreateColorscheme(termcolors, bg, fg, cursors)
  local ret = {}
  if type(termcolors)~='table' or type(bg)~='string' or type(fg)~='string' or type(cursors)~='table' then
    return nil
  end
  for i=1,16,1 do
    if type(termcolors[i])~='string' then
      return nil
    end
    ret[i] = termcolors[i]
  end
  ret[17] = bg
  ret[18] = fg
  ret[19] = cursors.normal
  ret[20] = cursors.inverse
  if ret[19]==nil or ret[20] == nil then
    return nil
  end
  return ret
  end
