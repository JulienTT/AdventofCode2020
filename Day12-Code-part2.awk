function rotate(theta,wx2,wy2){
    wx2 = cos(theta)*wx-sin(theta)*wy;
    wy2 = sin(theta)*wx+cos(theta)*wy;
    wx=wx2;
    wy=wy2;
}

BEGIN{x=0;y=0;wx=10;wy=1;pi = atan2(0, -1)}

{
    dir=substr($1,1,1);
    number=substr($1,2);
    switch (dir){
    case "N":
	wy += number;
	break;
    case "S":
	wy -= number;
	break;
    case "E":
	wx += number;
	break;
    case "W":
	wx -= number;
	break;
    case "R":
	theta=(-number*pi/180);
	rotate(theta);
	break;
    case "L":
	theta=(number*pi/180);
	rotate(theta);
	break;
    case "F":
	x += number*wx;
	y += number*wy;
	break;
    default:
	print "mismatch";
	exit 1;
    }
}

END{

    x=((x>0)?x:(-x));
    y=((y>0)?y:(-y));
    
    print x+y;
}
