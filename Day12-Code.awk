BEGIN{x=0;y=0;theta=0;pi = atan2(0, -1)}

{
    dir=substr($1,1,1);
    number=substr($1,2);
    switch (dir){
    case "N":
	y += number;
	break;
    case "S":
	y -= number;
	break;
    case "E":
	x += number;
	break;
    case "W":
	x -= number;
	break;
    case "R":
	theta -= number;
	break;
    case "L":
	theta += number;
	break;
    case "F":
	x += number*cos(theta*pi/180);
	y += number*sin(theta*pi/180);
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
