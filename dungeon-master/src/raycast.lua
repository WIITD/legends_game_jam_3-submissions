-- raycast
raycast={}

function raycast:render(lbl)
	local x,y,r,vx,vy,ox,oy,dx,dy,ix,iy
	local h,cs,fac=32,{13,4,12},1
	local cnt=1
	
	for i=0,127 do
		x=player.x
		y=player.y
		r=player.rot
		
		-- find ray direction
		vx=cos(r+atan2(1,(i-64)/64))
		vy=sin(r+atan2(1,(i-64)/64))
		fac=cos(atan2(1,(i-64)/64))
		
		
		dx=abs(1/vx)
		dy=abs(1/vy)
		ix=vx>0 and 1 or -1
		iy=vy>0 and 1 or -1
		if vx>0 then
			ox=(flr(x)-x+1)/vx
		else
			ox=abs((x-flr(x))/vx)
		end
		if vy>0 then
			oy=(flr(y)-y+1)/vy
		else
			oy=abs((y-flr(y))/vy)
		end
		
		while true do
			-- horizontal intersection
			if ox<oy then
				-- iterate raycast
				x+=ix
				d=ox
				ox+=dx
				-- check for collsion
				if mget(x,y)>0 or x<0 or x>64 or y<0 or y>64 then
					-- line endpoints (rounded)
					tw=flr(64-h/d/fac)
					bw=flr(64+h/d/fac)
					tline(i,tw,i,bw,(y+vy*d)%1*2+(mget(x,y)-1)*2,0,0,2/(bw-tw))
					cnt+=1
					if lbl and cnt%2==0 then
						print("\^1",0,0)
					end
					break
				end
			else -- vertical intersection
				y+=iy
				d=oy
				oy+=dy
				if mget(x,y)>0 or x<0 or x>64 or y<0 or y>64 then
					tw=flr(64-h/d/fac)
					bw=flr(64+h/d/fac)
					tline(i,tw,i,bw,(x+vx*d)%1*2+(mget(x,y)-1)*2,0,0,2/(bw-tw))
					cnt+=1
					if lbl and cnt%2==0 then
						print("\^1",0,0)
					end
					break
				end
			end
		end
	end
end
