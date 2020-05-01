public int numRows=20;
public int numCols=20;
public int boomCounter=0, endX=0,endY=0;
public boolean open=true, boomCheck=false, gameOver=false, gameOverMessageDisplay=false;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList<MSButton> mines; //ArrayList of just the minesweeper buttons that are mined
//mines=new MSButton[][];
ArrayList<Integer> mineX=new ArrayList<Integer>();
ArrayList<Integer> mineY=new ArrayList<Integer>();
PImage flag;
PImage minefield;
PImage opening;
PImage frame1,frame2,frame3,frame4,frame5,frame6,frame7,frame8;
PImage[] mineBoom=new PImage[8];
public void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    flag=loadImage("flag.png");
    minefield=loadImage("minefield.jpeg");
    opening=loadImage("opening.jpeg");
    for(int i=1; i<=mineBoom.length; i++)
    {
        mineBoom[i-1]=loadImage("frame"+i+".gif");
    }
    //your code to initialize buttons goes here
    buttons=new MSButton[numRows][numCols];
    for(int a=0; a<numRows;a++)
    {
        for(int b=0;b<numCols;b++)
        {
            buttons[a][b]=new MSButton(a,b);
        }
    }
    setMines();
    checkAround();
    freeSpace();
    for(int a=0;a<20;a++)
    {
        for(int b=0;b<20;b++)
        {
            println(b+","+a+": "+buttons[b][a].bomb+","+buttons[b][a].ring);
        }
    }
}

public void freeSpace()
{
    if(buttons[10][10].bomb==false&&buttons[10][10].ring==0)
    {
        buttons[10][10].start=true;
    }else if(buttons[10][11].bomb==false&&buttons[10][11].ring==0)
    {
        buttons[10][11].start=true;
    }else if(buttons[11][11].bomb==false&&buttons[11][11].ring==0)
    {
        buttons[11][11].start=true;
    }else if(buttons[11][10].bomb==false&&buttons[11][10].ring==0)
    {
        buttons[11][10].start=true;
    }else if(buttons[11][9].bomb==false&&buttons[11][9].ring==0)
    {
        buttons[11][9].start=true;
    }else if(buttons[10][9].bomb==false&&buttons[10][9].ring==0)
    {
        buttons[10][9].start=true;
    }else if(buttons[9][9].bomb==false&&buttons[9][9].ring==0)
    {
        buttons[9][9].start=true;
    }else if(buttons[9][10].bomb==false&&buttons[9][10].ring==0)
    {
        buttons[9][10].start=true;
    }else if(buttons[9][11].bomb==false&&buttons[9][11].ring==0)
    {
        buttons[9][11].start=true;
    }
}

public void checkAround()
{
    for(int c=0;c<numRows;c++)
    {
        for(int d=0;d<numCols;d++)
        {
            if(isValid(c,d+1))
            {
                if(buttons[c][d+1].bomb)
                {
                    buttons[c][d].ring++;
                }
            }
            if(isValid(c+1,d+1))
            {
                if(buttons[c+1][d+1].bomb)
                {
                    buttons[c][d].ring++;
                }
            }
            if(isValid(c+1,d))
            {
                if(buttons[c+1][d].bomb)
                {
                    buttons[c][d].ring++;
                }
            }
            if(isValid(c+1,d-1))
            {
                if(buttons[c+1][d-1].bomb)
                {
                    buttons[c][d].ring++;
                }
            }
            if(isValid(c,d-1))
            {
                if(buttons[c][d-1].bomb)
                {
                    buttons[c][d].ring++;
                }
            }
            if(isValid(c-1,d-1))
            {
                if(buttons[c-1][d-1].bomb)
                {
                    buttons[c][d].ring++;
                }
            }
            if(isValid(c-1,d))
            {
                if(buttons[c-1][d].bomb)
                {
                    buttons[c][d].ring++;
                }
            }
            if(isValid(c-1,d+1))
            {
                if(buttons[c-1][d+1].bomb)
                {
                    buttons[c][d].ring++;
                }
            }
        }   
    }
}

public void setMines()
{
    //your code
    int numberMines=50;
    for(int a=0;a<numberMines;a++)
    {
        mineX.add((int)(Math.random()*numCols));
        mineY.add((int)(Math.random()*numRows));
        buttons[mineX.get(a)][mineY.get(a)].bomb=true;
    }
}

public void draw()
{
    if(open==true)
    {
        background(0);
        image(opening,0,0,400,400);
        fill(255,255,255);
        rect(200,190,280,60);
        fill(0,0,0);
        textSize(30);
        text("press space",300,200);
        text("to start",300,230);
        textSize(10);
    }else if(open==false)
    {
        background(0);
        image(minefield,0,0,400,400);
        if(isWon() == true)
            displayWinningMessage();
        for(int a=0; a<buttons.length;a++)
        {
            for(int b=0;b<buttons[a].length;b++)
            {
                buttons[a][b].draw();
               // buttons[a][b].mousePressed();
                if(buttons[a][b].clicked)
                {
                    //bleh
                }
            }
        }
        boomCounter();
        if(gameOver)
        {
            for(int a=0;a<buttons.length;a++)
            {
                for(int b=0;b<buttons[a].length;b++)
                {
                    if(buttons[a][b].bomb==true)
                    {
                        buttons[a][b].clicked=true;
                    }
                }
            }
            if(boomCheck==false)
            {
                boomCounter=0;
                boomCheck=true;
            }
        }
        if(gameOverMessageDisplay)
        {
            fill(255,255,255);
            rect(50,180,300,50);
            fill(255,0,0);
            textSize(50);
            text("GAME OVER",200,200);
            textSize(10);
            println("GAME OVER");
        }
    }
}
public void keyPressed() 
{
    switch(key){
        case ' ':
            if(open==true)
            {
                open=false;
                println("start is false");
            }
        break;
    }
}
public void mousePressed()
{
    int r = mouseY/numCols;
    int c = mouseX/numRows;
    if(open==false)
    {
        buttons[r][c].mousePressed();
    }
}
    
//     for(int a=0;a<buttons.length;a++)
//     {
//         for(int b=0;b<buttons[a].length;b++)
//         {
//             if(mousePressed&&mouseButton==RIGHT&&buttons[a][b].clicked!=true)
//             {
//                 if(mouseX>buttons[a][b].x&&mouseX<buttons[a][b].x+wid&&mouseY>buttons[a][b].y&&mouseY<buttons[a][b].y+hei)
//                 {
//                     if(flagQ==true)
//                         buttons[a][b].flagged=true;
//                     if(flagged==false)
//                         buttons[a][b].flagged=false;
//                     println("flagged");
//                 }
//             }
//         }
//     }
boolean overButton(int x, int y, int width, int height)  {
    if(mouseX>=x&&mouseX<=x+width&&mouseY>=y&&mouseY<=y+height)
    {
        return true;
    }else{
        return false;
    }
}
public void softClick(int x, int y)
{
    //boolean surro=false;
    if(isValid(x+1,y)&&buttons[y][x+1].clicked==false&&buttons[y][x+1].bomb==false&&buttons[y][x+1].ring==0)
    //add not a bomb later
    {
        buttons[y][x+1].clicked=true;
        println(x+1, y);
        softClick(x+1,y);
    }
    if(isValid(x+1,y+1)&&buttons[y+1][x+1].clicked==false&&buttons[y+1][x+1].bomb==false&&buttons[y+1][x+1].ring==0)
    //add not a bomb later
    {
        buttons[y+1][x+1].clicked=true;
        println(x+1, y+1);
        softClick(x+1,y+1);
    }
    if(isValid(x,y+1)&&buttons[y+1][x].clicked==false&&buttons[y+1][x].bomb==false&&buttons[y+1][x].ring==0)
    //add not a bomb later
    {
        buttons[y+1][x].clicked=true;
        println(x, y+1);
        softClick(x,y+1);
    }
    if(isValid(x-1,y+1)&&buttons[y+1][x-1].clicked==false&&buttons[y+1][x-1].bomb==false&&buttons[y+1][x-1].ring==0)
    //add not a bomb later
    {
        buttons[y+1][x-1].clicked=true;
        println(x-1, y+1);
        softClick(x-1,y+1);
    }
    if(isValid(x-1,y)&&buttons[y][x-1].clicked==false&&buttons[y][x-1].bomb==false&&buttons[y][x-1].ring==0)
    //add not a bomb later
    {
        buttons[y][x-1].clicked=true;
        println(x-1, y);
        softClick(x-1,y);
    }
    if(isValid(x-1,y-1)&&buttons[y-1][x-1].clicked==false&&buttons[y-1][x-1].bomb==false&&buttons[y-1][x-1].ring==0)
    //add not a bomb later
    {
        buttons[y-1][x-1].clicked=true;
        println(x-1, y-1);
        softClick(x-1,y-1);
    }
    if(isValid(x,y-1)&&buttons[y-1][x].clicked==false&&buttons[y-1][x].bomb==false&&buttons[y-1][x].ring==0)
    //add not a bomb later
    {
        buttons[y-1][x].clicked=true;
        println(x, y-1);
        softClick(x,y-1);
    }
    if(isValid(x+1,y-1)&&buttons[y-1][x+1].clicked==false&&buttons[y-1][x+1].bomb==false&&buttons[y-1][x+1].ring==0)
    //add not a bomb later
    {
        buttons[y-1][x+1].clicked=true;
        println(x+1, y-1);
        softClick(x+1,y-1);
    }







    if(isValid(x+1,y)&&buttons[y][x+1].clicked==false&&buttons[y][x+1].bomb==false)
    //add not a bomb later
    {
        buttons[y][x+1].clicked=true;
    }
    if(isValid(x+1,y+1)&&buttons[y+1][x+1].clicked==false&&buttons[y+1][x+1].bomb==false)
    //add not a bomb later
    {
        buttons[y+1][x+1].clicked=true;
    }
    if(isValid(x,y+1)&&buttons[y+1][x].clicked==false&&buttons[y+1][x].bomb==false)
    
    {
        buttons[y+1][x].clicked=true;
    }
    if(isValid(x-1,y+1)&&buttons[y+1][x-1].clicked==false&&buttons[y+1][x-1].bomb==false)
    //add not a bomb later
    {
        buttons[y+1][x-1].clicked=true;
    }
    if(isValid(x-1,y)&&buttons[y][x-1].clicked==false&&buttons[y][x-1].bomb==false)
    //add not a bomb later
    {
        buttons[y][x-1].clicked=true;
    }
    if(isValid(x-1,y-1)&&buttons[y-1][x-1].clicked==false&&buttons[y-1][x-1].bomb==false)
    //add not a bomb later
    {
        buttons[y-1][x-1].clicked=true;
    }
    if(isValid(x,y-1)&&buttons[y-1][x].clicked==false&&buttons[y-1][x].bomb==false)
    //add not a bomb later
    {
        buttons[y-1][x].clicked=true;
    }
    if(isValid(x+1,y-1)&&buttons[y-1][x+1].clicked==false&&buttons[y-1][x+1].bomb==false)
    //add not a bomb later
    {
        buttons[y-1][x+1].clicked=true;
    }
}







public void bombSpread(int x, int y)
{
    //boolean surro=false;
    if(isValid(x+1,y)&&buttons[y][x+1].bomb==false&&buttons[y][x+1].boomClicked==false)
    //add not a bomb later
    {
        buttons[y][x+1].boomClicked=true;
        bombSpread(x+1,y);
    }
    if(isValid(x+1,y+1)&&buttons[y+1][x+1].bomb==false&&buttons[y+1][x+1].boomClicked==false)
    //add not a bomb later
    {
        buttons[y+1][x+1].boomClicked=true;
        bombSpread(x+1,y+1);
    }
    if(isValid(x,y+1)&&buttons[y+1][x].bomb==false&&buttons[y+1][x].boomClicked==false)
    //add not a bomb later
    {
        buttons[y+1][x].boomClicked=true;
        bombSpread(x,y+1);
    }
    if(isValid(x-1,y+1)&&buttons[y+1][x-1].bomb==false&&buttons[y+1][x-1].boomClicked==false)
    //add not a bomb later
    {
        buttons[y+1][x-1].boomClicked=true;
        bombSpread(x-1,y+1);
    }
    if(isValid(x-1,y)&&buttons[y][x-1].bomb==false&&buttons[y][x-1].boomClicked==false)
    //add not a bomb later
    {
        buttons[y][x-1].boomClicked=true;
        bombSpread(x-1,y);
    }
    if(isValid(x-1,y-1)&&buttons[y-1][x-1].bomb==false&&buttons[y-1][x-1].boomClicked==false)
    //add not a bomb later
    {
        buttons[y-1][x-1].boomClicked=true;
        bombSpread(x-1,y-1);
    }
    if(isValid(x,y-1)&&buttons[y-1][x].bomb==false&&buttons[y-1][x].boomClicked==false)
    //add not a bomb later
    {
        buttons[y-1][x].boomClicked=true;
        bombSpread(x,y-1);
    }
    if(isValid(x+1,y-1)&&buttons[y-1][x+1].bomb==false&&buttons[y-1][x+1].boomClicked==false)
    //add not a bomb later
    {
        buttons[y-1][x+1].boomClicked=true;
        bombSpread(x+1,y-1);
    }








    if(isValid(x+1,y)&&buttons[y][x+1].bomb==true)
    //add not a bomb later
    {
        buttons[y][x+1].boom=true;
    }else if(isValid(x+1,y+1)&&buttons[y+1][x+1].bomb==true)
    //add not a bomb later
    {
        buttons[y+1][x+1].boom=true;
    }else if(isValid(x,y+1)&&buttons[y+1][x].bomb==true)
    
    {
        buttons[y+1][x].boom=true;
    }else if(isValid(x-1,y+1)&&buttons[y+1][x-1].bomb==true)
    //add not a bomb later
    {
        buttons[y+1][x-1].boom=true;
    }else if(isValid(x-1,y)&&buttons[y][x-1].bomb==true)
    //add not a bomb later
    {
        buttons[y][x-1].boom=true;
    }else if(isValid(x-1,y-1)&&buttons[y-1][x-1].bomb==true)
    //add not a bomb later
    {
        buttons[y-1][x-1].boom=true;
    }else if(isValid(x,y-1)&&buttons[y-1][x].bomb==true)
    //add not a bomb later
    {
        buttons[y-1][x].boom=true;
    }else if(isValid(x+1,y-1)&&buttons[y-1][x+1].bomb==true)
    //add not a bomb later
    {
        buttons[y-1][x+1].boom=true;
    }
}

void boomCounter()
{
    if(boomCounter<=105&&boomCheck)
    {
        if((boomCounter/3<7)&&boomCounter<21)
        {
            image(mineBoom[(int)(boomCounter/3)],50,50,100,100);
        }
        if(((boomCounter-21)/3<7)&&boomCounter>=21&&boomCounter<42)
        {
            image(mineBoom[(int)((boomCounter-21)/3)],250,50,100,100);
        }
        if(((boomCounter-42)/3<7)&&boomCounter>=42&&boomCounter<63)
        {
            image(mineBoom[(int)((boomCounter-42)/3)],250,250,100,100);
        }
        if(((boomCounter-63)/3<7)&&boomCounter>=63&&boomCounter<84)
        {
            image(mineBoom[(int)((boomCounter-63)/3)],50,250,100,100);
        }
        if(((boomCounter-84)/3<7)&&boomCounter>=84&&boomCounter<105)
        {
            image(mineBoom[(int)((boomCounter-84)/3)],100,100,200,200);
        }
        if(boomCounter>=105)
        {
            gameOverMessageDisplay=true;
            println("GAMEOVERMESSAGEDISPLAY");
            boomCheck=false;
            boomCounter=0;
        }
        if(boomCheck)
        {
            boomCounter++;
            println(boomCounter);
            println(boomCheck);
        }
    }
}


public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}
public boolean isValid(int r, int c)
{
    //your code here
    if(r>-1&&r<numRows&&c>-1&&c<numCols)
    {
        return true;
    }
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    //your code here
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;//, numRows, numCols;
    public int ring=0;
    private float x,y, wid, hei;
    private boolean clicked, flagged, bomb, start, boom, boomClicked;
    private String myLabel;
    public MSButton ( int row, int col )
    {
        clicked=false;//check the examples->contributed libraries->guido->button
        flagged=false;
        start=false;
        bomb=false;
        boom=false;
        boomClicked=false;
        wid = 400/numCols;
        hei = 400/numRows;
        myRow = row;
        myCol = col; 
        x = myCol*wid;
        y = myRow*hei;
        myLabel = "";
        //Interactive.add( this ); // register it with the manager
    }

    /*public void mouseReleased() 
    {
        if(!mousePressed&&mouseButton==RIGHT&&clicked!=true)
        {
            if(mouseX>x&&mouseX<x+wid&&mouseY>y&&mouseY<y+hei)
            {
                flagged=!flagged;
                println("flagged");
            }
        }
    }*/
    // called by manager
    public void mousePressed() 
    {
        if(mousePressed&&mouseButton==LEFT&&bomb)
        {
            gameOver=true;
        }
        if(mousePressed&&mouseButton==RIGHT&&clicked!=true)
        {
            if(mouseX>x&&mouseX<x+wid&&mouseY>y&&mouseY<y+hei)
            {
                // if(flagQ==true)
                //     flagged=true;
                // if(flagQ==false)
                //     flagged=false;
                flagged=!flagged;
                println("flagged");
            }
        }
        if(mousePressed&&flagged==false&&mouseButton==LEFT)
        {
            if(mouseX>x&&mouseX<x+wid&&mouseY>y&&mouseY<y+hei&&bomb==false)
            {
                if(ring==0)
                {
                    clicked = true;
                    softClick(myCol, myRow);
                    println(myRow+", "+myCol+" has been clicked");
                }
                if(ring>0&&flagged==false)
                {
                    clicked=true;
                    fill(255,255,0);
                    text(ring,x+wid/2,y+hei/2);
                    noFill();
                    //println("ring"+x+","+y);
                }
            }
        }
    }
        //your code here
    public void draw () 
    {    
        if(flagged==false)
        {
            if(clicked)
            {
                fill(0,255,0,100);
                if(ring>0&&bomb==false)
                {
                    fill(0,0,255,100);
                }
                if(bomb==true)
                {
                    fill(255,0,0);
                }
            }else if(start)
            {
                fill(50,50,50,100);
            }else{
                fill(125,125,125,0);
            }
            // if(bomb&&clicked==true)
            // {
            //     fill(255,0,0);
            // }
            rect(x, y, wid, hei);
        }
        else
        {
            fill(127, 127, 0);
            rect(x, y, wid, hei);
            image(flag,x,y,wid,hei);
        }

        if(flagged)
        {
            fill(127, 127, 0);
            image(flag,x,y,wid,hei);

        }else if(ring>0&&clicked&&flagged==false&&bomb==false)
        {
            fill(255,255,0);
            text(ring,x+wid/2,y+hei/2);
        }
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}

//use the code below as a game feature later
/*
public int numRows=20;
public int numCols=20;
private MSButton[][] buttons; 
private ArrayList<MSButton> mines; 
ArrayList<Integer> mineX=new ArrayList<Integer>();
ArrayList<Integer> mineY=new ArrayList<Integer>();
public void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    buttons=new MSButton[numRows][numCols];
    for(int a=0; a<numRows;a++)
    {
        for(int b=0;b<numCols;b++)
        {
            buttons[a][b]=new MSButton(a,b);
        }
    } 
    setMines();
    for(int c=0;c<numRows;c++)
    {
        for(int d=0;d<numCols;d++)
        {
            if(isValid(c,d+1))
            {
                if(buttons[c][d+1].bomb)
                {
                    buttons[c][d].ring++;
                }
            }
            if(isValid(c+1,d+1))
            {
                if(buttons[c+1][d+1].bomb)
                {
                    buttons[c][d].ring++;
                }
            }
            if(isValid(c+1,d))
            {
                if(buttons[c+1][d].bomb)
                {
                    buttons[c][d].ring++;
                }
            }
            if(isValid(c+1,d-1))
            {
                if(buttons[c+1][d-1].bomb)
                {
                    buttons[c][d].ring++;
                }
            }
            if(isValid(c,d-1))
            {
                if(buttons[c][d-1].bomb)
                {
                    buttons[c][d].ring++;
                }
            }
            if(isValid(c-1,d-1))
            {
                if(buttons[c-1][d-1].bomb)
                {
                    buttons[c][d].ring++;
                }
            }
            if(isValid(c-1,d))
            {
                if(buttons[c-1][d].bomb)
                {
                    buttons[c][d].ring++;
                }
            }
            if(isValid(c-1,d+1))
            {
                if(buttons[c-1][d+1].bomb)
                {
                    buttons[c][d].ring++;
                }
            }
        }   
    }
    for(int a=0;a<20;a++)
    {
        for(int b=0;b<20;b++)
        {
            println(b+","+a+": "+buttons[b][a].bomb+","+buttons[b][a].ring);
        }
    }
}
public void setMines()
{
    int numberMines=50;
    for(int a=0;a<numberMines;a++)
    {
        mineX.add((int)(Math.random()*numCols));
        mineY.add((int)(Math.random()*numRows));
        buttons[mineX.get(a)][mineY.get(a)].bomb=true;
    }
}

public void draw()
{
    background(0);
    if(isWon() == true)
        displayWinningMessage();
    for(int a=0; a<buttons.length;a++)
    {
        for(int b=0;b<buttons[a].length;b++)
        {
            buttons[a][b].draw();
            buttons[a][b].mousePressed();
        }
    }
}
public void softClick(int x, int y)
{
    if(isValid(x+1,y)&&buttons[y][x+1].clicked==false&&buttons[y][x+1].bomb==false&&buttons[y][x+1].ring==0)
    {
        buttons[y][x+1].clicked=true;
        softClick(x+1,y);
    }
    if(isValid(x+1,y+1)&&buttons[y+1][x+1].clicked==false&&buttons[y+1][x+1].bomb==false&&buttons[y+1][x+1].ring==0)
    {
        buttons[y+1][x+1].clicked=true;
        softClick(x+1,y+1);
    }
    if(isValid(x,y+1)&&buttons[y+1][x].clicked==false&&buttons[y+1][x].bomb==false&&buttons[y+1][x].ring==0)
    {
        buttons[y+1][x].clicked=true;
        softClick(x,y+1);
    }
    if(isValid(x-1,y+1)&&buttons[y+1][x-1].clicked==false&&buttons[y+1][x-1].bomb==false&&buttons[y+1][x-1].ring==0)
    {
        buttons[y+1][x-1].clicked=true;
        softClick(x-1,y+1);
    }
    if(isValid(x-1,y)&&buttons[y][x-1].clicked==false&&buttons[y][x-1].bomb==false&&buttons[y][x-1].ring==0)
    {
        buttons[y][x-1].clicked=true;
        softClick(x-1,y);
    }
    if(isValid(x-1,y-1)&&buttons[y-1][x-1].clicked==false&&buttons[y-1][x-1].bomb==false&&buttons[y-1][x-1].ring==0)
    {
        buttons[y-1][x-1].clicked=true;
        softClick(x-1,y-1);
    }
    if(isValid(x,y-1)&&buttons[y-1][x].clicked==false&&buttons[y-1][x].bomb==false&&buttons[y-1][x].ring==0)
    {
        buttons[y-1][x].clicked=true;
        softClick(x,y-1);
    }
    if(isValid(x+1,y-1)&&buttons[y-1][x+1].clicked==false&&buttons[y-1][x+1].bomb==false&&buttons[y-1][x+1].ring==0)
    {
        buttons[y-1][x+1].clicked=true;
        softClick(x+1,y-1);
    }
    if(isValid(x,y)&&buttons[y][x].ring>0)
    {
        buttons[y][x].clicked=true;
    }
}

public boolean isValid(int r, int c)
{
    if(r>-1&&r<numRows&&c>-1&&c<numCols)
    {
        return true;
    }
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    public int ring=0;
    private float x,y, wid, hei;
    private boolean clicked, flagged, bomb;
    private String myLabel;
    public MSButton ( int row, int col )
    {
        clicked=false;
        flagged=false;
        bomb=false;
        wid = 400/numCols;
        hei = 400/numRows;
        myRow = row;
        myCol = col; 
        x = myCol*wid;
        y = myRow*hei;
        myLabel = "";
    }
    public void mousePressed() 
    {
        if(mousePressed)
        {
            if(mouseX>x&&mouseX<x+wid&&mouseY>y&&mouseY<y+hei&&bomb==false)
            {
                if(ring==0)
                {
                    clicked = true;
                    softClick(myCol, myRow);
                    println(myRow+", "+myCol+" has been clicked");
                }
                if(ring>0)
                {
                    clicked=true;
                    fill(255,255,0);
                    text(ring,x+wid/2,y+hei/2);
                }
            }
        }
    }
    public void draw () 
    {    
        if(clicked)
        {
            fill(255,0,0);
            if(ring>0)
            {
                fill(0,0,255);
            }
        }else 
            fill(255,255,255);
        if(bomb)
            fill(0,255,0);
        rect(x, y, wid, hei);
        if(ring>0&&clicked)
        {
            fill(255,255,0);
            text(ring,x+wid/2,y+hei/2);
        }
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}*/
