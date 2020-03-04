//slowly try and get rid of guido assistance
public int numRows=20;
public int numCols=20;
public boolean flagQ = true;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList<MSButton> mines; //ArrayList of just the minesweeper buttons that are mined
//mines=new MSButton[][];
ArrayList<Integer> mineX=new ArrayList<Integer>();
ArrayList<Integer> mineY=new ArrayList<Integer>();
PImage flag;
PImage minefield;
public void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    flag=loadImage("flag.png");
    minefield=loadImage("minefield.jpeg");
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
    //while(buttons[(int)(Math.random()*numRows)][(int)(Math.random()*numCols)].bomb==false&&buttons[(int)(Math.random()*numRows)][(int)(Math.random()*numCols)].ring==0)
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
    keyPressed();
}


public void keyPressed()
{
    switch (key)
    {
        case 'z':
            flagQ=true;
            println("flag");
        break;
        case 'x':
            flagQ=false;
            println("pole");
        break;
    }
}

 public void mousePressed() 
 {
    int r = mouseY/numCols;
    int c = mouseX/numRows;
    buttons[r][c].mousePressed();
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
    private boolean clicked, flagged, bomb, start;
    private String myLabel;
    public MSButton ( int row, int col )
    {
        clicked=false;//check the examples->contributed libraries->guido->button
        flagged=false;
        start=false;
        bomb=false;
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
        //your code here
    }
    public void draw () 
    {    
        /*if(mousePressed)
        {
            if(mouseX>x&&mouseX<x+wid&&mouseY>y&&mouseY<y+wid)
            {
                clicked = true;
                System.out.println("Clicked: " + clicked);
            }
        }*/
        //if(flagged)
            //fill(0);
        // else if( clicked && mines.contains(this) ) 
        //     fill(255,0,0);
        if(flagged==false)
        {
            if(clicked)
            {
                fill(0,255,0,100);
                if(ring>0)
                {
                    fill(0,0,255,100);
                }
            }else if(start)
            {
                fill(50,50,50,100);
            }else{
                fill(125,125,125,0);
            }
            //if(bomb)
            //    fill(0,255,0);
            //fix this shit
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

        }else if(ring>0&&clicked&&flagged==false)
        {
            fill(255,255,0);
            text(ring,x+wid/2,y+hei/2);
        }
        //fill(0);
        //text(myLabel,x+wid/2,y+hei/2);
    }
    /*
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }*/
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