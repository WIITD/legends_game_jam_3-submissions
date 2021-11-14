ui = {}

function ui:bbox(x,y,w,h)
	rectfill(x,y,w,h,0)
	rect(x+1,y+1,w-1,h-1,6)
end
