public class MazePrototypeFactory extends MazeFactory
{
    public MazePrototypeFactory(Maze m, Wall w, Room r, Door d)   
    { 
	_prototypeMaze = m;
	_prototypeWall = w;
	_prototypeRoom = r;
	_prototypeDoor = d;
    }
    public Maze MakeMaze();
    public Room MakeRoom(int);
    public Wall MakeWall()
    {
	return _prototypeWall.Clone();
    }
    public Door MakeDoor(Room r1, Room r2)
    {
	Door door = _prototypeDoor.Clone();
	door.Initialize(r1, r2);
	return door;
    }   
    private Maze _prototypeMaze;
    private Room _prototypeRoom;
    private Wall _prototypeWall;
    private Door _prototypeDoor;
}


MazeGame game;
MazePrototypeFactory simpleMazeFactory(new Maze(), new Wall(), new Room(), 
				       new Door());  
Maze maze = game.CreateMaze(simpleMazeFactory);

MazePrototypeFactory bombedMazeFactory(new Maze(), new BombedWall(),
				       new RoomWithABomb(), new Door());
   
public class Door extends MapSite
{
    public Door();
    public  Door(Door other)
    {
	_room1 = other._room1;
	_room2 = other._room2;
    }
    public void Initialize(Room r1, Room r2)
    {
	_room1 = r1;
	_room2 = r2;
    }
    public Door Clone()
    {
	return new Door(this);
    }
    
    public void Enter();
    public Room OtherSideFrom(Room);
    private Room _room1;
    private  Room _room2;
}
    
public class BombedWall extends Wall
{
    public BombedWall();
    public  BombedWall(BombedWall other)
    {
	super (other);
	_bomb = other._bomb;
    }
    public Wall Clone()
    {
	return new BombedWall(this);
    }

    public  boolean HasBomb();
    private boolean _bomb;
}
