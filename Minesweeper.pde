import de.bezier.guido.*;
int numRows=20;
int numCols=20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined
//mines=new MSButton[][];
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons=new MSButton[20][20];
    for(int a=0; a<20;a++)
    {
        for(int b=0;b<20;b++)
        {
            buttons[b][a]=new MSButton(b, a);
        }
    }
    setMines();
}
public void setMines()
{
    //your code
}

public void draw ()
{
    background(0);
    if(isWon() == true)
        displayWinningMessage();
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
    private float x,y, wid, hei;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        clicked=false;//check the examples->contributed libraries->guido->button
        /*flagged=false;
        numRows=20;
        numCols=20;
        wid = 400/numCols;
        hei = 400/numRows;
        myRow = row;
        myCol = col; 
        x = myCol*wid;
        y = myRow*hei;
        myLabel = "";
        flagged = clicked = false;*/
        wid=10;
        hei=10;
        x=col*wid;
        y=row*hei;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        //if(mouseX>x&&mouseX<x+wid&&mouseY>y&&mouseY<y+wid)
            clicked = ! clicked;
            System.out.println("Clicked: " + clicked);
        //your code here
    }
    public void draw () 
    {    
        //if(flagged)
            //fill(0);
        // else if( clicked && mines.contains(this) ) 
        //     fill(255,0,0);
        if(clicked)
            fill(0);
        else 
            fill(255);

        rect(x, y, wid, hei);
        //fill(0);
        //text(myLabel,x+wid/2,y+hei/2);
    }
    /*
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }*/
}
