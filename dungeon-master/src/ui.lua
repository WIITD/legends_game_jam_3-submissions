-- ui
 ui={}
-- borderd box
function ui:bbox(x, y, w, h)
	rectfill(x, y, w, h,0)
	rect(x+1, y+1, w-1, h-1, 6)
end

-- render raycast frame
function ui:rrender()
	for x = 0, 128 do
		rectfill(0, 0, x, 128, 1)
		if x % 3 == 0 then print("\^1", 0, 0) end
	end
	raycast:render(true)
end
