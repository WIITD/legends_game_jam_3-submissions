collision={}

-- check collision
function collision:check(x,y,dx,dy, flag)
	n=mget(x, y)

	-- open normal chest
	-- collision:open(x,y,n,4,7,0,chest_normal)

	return fget(n,flag)
	--return false
end

-- open 
function collision:open(x,y,tile,tag,to,sound, func)
	if fget(n, tag) then
		sfx(sound)
		func()
		mset(x, y, to)
		return true
	end
end
