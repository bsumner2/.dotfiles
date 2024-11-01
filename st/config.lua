require('helpers.cursorshapes')
require('helpers.functions')
CursorShape = CursorUnderline
-- require('colors.flattened_darker')
-- require('colors.dark_matter')
-- require('colors.gruvbox')
-- require('colors.aurelia_deep')
-- require('colors.challenger_deep')
-- require('colors.aurelia_challenger')
-- require('colors.oxford_blues')
--[[ ColorScheme = CreateColorscheme(
  {
    "#42444D",
    "#FC2E51",
    "#25A45C",
    "#FF9369",
    "#3375FE",
    "#9F7EFE",
    "#4483AA",
    "#CDD3E0",
    "#8F9AAE",
    "#FF637F",
    "#3FC56A",
    "#F9C858",
    "#10B0FE",
    "#FF78F8",
    "#5FB9BC",
    "#FFFFFF",
  },
--  "#282C34",  -- Dark hue
--  "#181A1F",  -- Darker hue
  "#14161A",  -- Even darker hue
  "#ABB2BF",
  {
    normal="#ABB2BF",
    inverse="#544D40"
  }
) ]]--
if type(ColorScheme)=='nil' then
  require('colors.monokai')
end
Alpha = .97
Font = 'IosevkaTerm Nerd Font'
-- Font = 'Comic Mono'
FontSize = 16
