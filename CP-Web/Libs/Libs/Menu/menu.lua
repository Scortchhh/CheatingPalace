if _G.Menu ~= nil then
    return _G.Menu
end

--register global context
ctx = Renderer:MenuContext()

_G.Menu = {
	MenuTable = {},
	CreateMenu = function(self, name)
		NewMenu = {
			Name = name,
			Widgets = {},
			AddSubMenu = function(self, name)
				NewSubMenu ={
					Type = "SubMenu",
					Name = name,
					Widgets = {},
					DrawMenu = self.DrawMenu,
					DrawCheckbox = self.DrawCheckbox,
					DrawCombobox = self.DrawCombobox,
					DrawLabel = self.DrawLabel,
					DrawSlider = self.DrawSlider,
					DrawColorPicker = self.DrawColorPicker,
					AddSubMenu = self.AddSubMenu,
					AddCheckbox = self.AddCheckbox,
					AddCombobox = self.AddCombobox,
					AddLabel = self.AddLabel,
					AddSlider = self.AddSlider,
					AddColorPicker = self.AddColorPicker
				}
				table.insert(self.Widgets, NewSubMenu)
				return NewSubMenu
			end,
			AddCheckbox = function(self, name, value)
				NewCheckbox = {
					Type = "Checkbox",
					Name = name,
					Value = value,
					DrawCheckbox = self.DrawCheckbox
				}
				table.insert(self.Widgets, NewCheckbox)
				return NewCheckbox
			end,
			AddCombobox = function(self, name, items)
				NewCombobox = {
					Type = "Combobox",
					Name = name,
					Items = items,
					Selected = 1,
					DrawCombobox = self.DrawCombobox
				}
				table.insert(self.Widgets, NewCombobox)
				return NewCombobox
			end,
			AddLabel = function(self, labelText)
				NewLabel = {
					Type = "Label",
					Text = labelText,
					DrawLabel = self.DrawLabel
				}
				table.insert(self.Widgets, NewLabel)
				return NewLabel			
			end,			
			AddSlider = function(self, sliderText, value, minVal, maxVal, Step)
				NewSlider = {
					Type = "Slider",
					Text = sliderText,
					Value = value,
					Min = minVal,
					Max = maxVal,
					Step = step,
					DrawSlider = self.DrawSlider
				}
				table.insert(self.Widgets, NewSlider)
				return NewSlider			
			end,			
			AddColorPicker = function(self, name, r, g, b, a)
				NewColorPicker = {
					Type = "ColorPicker",
					Name = name,
					Value = nk_rgba(r, g, b, a),
					DrawColorPicker = self.DrawColorPicker
				}
				table.insert(self.Widgets, NewColorPicker)
				return NewColorPicker			
			end,			
			DrawMenu = function(self)
				local Widgets = self.Widgets
				if nk_tree_push_hashed(ctx, 1, self.Name, 0) ~= 0 then
					for WidgetIndex = 1 , #Widgets do
						local CurrentWidget = Widgets[WidgetIndex]
						if	CurrentWidget.Type == "SubMenu" then
							CurrentWidget:DrawMenu()
						end
						if	CurrentWidget.Type == "Checkbox" then
							CurrentWidget:DrawCheckbox()
						end
						if	CurrentWidget.Type == "Combobox" then
							CurrentWidget:DrawCombobox()
						end
						if	CurrentWidget.Type == "Label" then
							CurrentWidget:DrawLabel()
						end
						if	CurrentWidget.Type == "Slider" then
							CurrentWidget:DrawSlider()
						end
						if	CurrentWidget.Type == "ColorPicker" then
							CurrentWidget:DrawColorPicker()
						end
					end
					nk_tree_pop(ctx)
				end
			end,
			DrawCheckbox = function(self)
				self.Value = nk_check_label(ctx, self.Name, self.Value)		
			end,
			DrawCombobox = function(self)
				self.Selected = nk_combo(ctx, self.Items, self.Selected, 25, nk_vec2(200,200))
			end,
			DrawLabel = function(self)
				nk_label(ctx, self.Text, nk_text_alignment.NK_TEXT_LEFT)
			end,
			DrawSlider = function(self)
				self.Value = nk_propertyi(ctx, self.Text, self.Min, self.Value, self.Max, self.Step, 1.0)
			end,
			DrawColorPicker = function(self)
				nk_label(ctx, self.Name, nk_text_alignment.NK_TEXT_LEFT)
				nk_layout_row_dynamic(ctx, 500,1)
				self.Value = nk_color_picker(ctx, self.Value, 1)
				nk_layout_row_dynamic(ctx, 0,1)
			end
		}
		table.insert(self.MenuTable,NewMenu)
		return NewMenu
	end,
	RenderMenu = function()
		MenuIndex = 0
			local MenuTable = Menu.MenuTable
			for Index = 1, #MenuTable do
				local CurrentMenu = MenuTable[Index]
				if nk_tree_push_hashed(ctx, 1, CurrentMenu.Name, 0) ~= 0 then
					local Widgets = CurrentMenu.Widgets
					for WidgetIndex = 1 , #Widgets do
						local CurrentWidget = Widgets[WidgetIndex]
						if	CurrentWidget.Type == "SubMenu" then
							CurrentWidget:DrawMenu()
						end
						if	CurrentWidget.Type == "Checkbox" then
							CurrentWidget:DrawCheckbox()
						end
						if	CurrentWidget.Type == "Combobox" then
							CurrentWidget:DrawCombobox()
						end
						if	CurrentWidget.Type == "Label" then
							CurrentWidget:DrawLabel()
						end
						if	CurrentWidget.Type == "Slider" then
							CurrentWidget:DrawSlider()
						end
						if	CurrentWidget.Type == "ColorPicker" then
							CurrentWidget:DrawColorPicker()
						end				
					end
					nk_tree_pop(ctx)
				end
			end
		end
}

return _G.Menu
