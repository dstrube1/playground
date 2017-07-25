public class MazeBuilder
{

    protected MazeBuilder() {}
    public void BuildMaze() {}
    public void BuildRoom (int room) {}
    public void BuildDoor(int roomFrom, int roomTo) { }
    public Maze GetMaze() { return null; }

}

public class MazeGame
{

    public Maze CreateMaze (MazeBuilder builder)
    {
	builder.BuildMaze();
	builder.BuildRoom(1);
	builder.BuildRoom(2);
	builder.BuildDoor(1, 2);
	return builder.GetMaze();
    }

    public Maze CreateComplexMaze (MazeBuilder builder)
    {
	builder.BuildRoom(1);
	// ...
	builder.BuildRoom(1001);    
	return builder.GetMaze();
    }

}

public class StandardMazeBuilder extends MazeBuilder
{
    public StandardMazeBuilder()
    {
	_currentMaze = null;
    }
    public void BuildMaze()
    {
	_currentMaze = new Maze();
    }
    public void BuildRoom(int n)
    {
	if (!_currentMaze->RoomNo(n))
	    {
		Room room = new Room(n);
		_currentMaze.AddRoom(room);      
		room.SetSide(North, new Wall);
		room.SetSide(South, new Wall);
		room.SetSide(East, new Wall);
		room.SetSide(West, new Wall);
	    }
    } 
   public void BuildDoor(int n1, int n2)
    {
	Room r1 = _currentMaze.RoomNo(n1);
	Room r2 = _currentMaze.RoomNo(n2);
	Door d = new Door(r1, r2);    
	r1.SetSide(CommonWall(r1,r2), d);
	r2.SetSide(CommonWall(r2,r1), d);
    }
    public Maze GetMaze();
    private  Direction CommonWall(Room, Room);
    private Maze _currentMaze;
}

Maze maze;
MazeGame game;
StandardMazeBuilder builder;
    
game.CreateMaze(builder);
maze = builder.GetMaze();

public class CountingMazeBuilder extends MazeBuilder 
{
    public CountingMazeBuilder()
    {
	_rooms = _doors = 0;
    }    
    public void BuildMaze();
    public void BuildRoom(int)
    {
	_rooms++;
    }
    public void BuildDoor(int, int);
    public void AddWall(int, Direction);    
    public void GetCounts(int rooms, int doors)
    {
	rooms = _rooms;
	doors = _doors;
    }
    private int _doors;
    private int _rooms;
}

int rooms, doors;
MazeGame game;
CountingMazeBuilder builder;
    
game.CreateMaze(builder);
builder.GetCounts(rooms, doors);
    
System.out.println ("The maze has " + rooms + " rooms and " + doors + " doors");
