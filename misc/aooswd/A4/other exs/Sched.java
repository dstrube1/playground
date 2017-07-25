package psimjava;


// Referenced classes of package psimjava:
//            Pobject, Process, StaticSync

public class Sched extends Pobject
{

    public static final int IDLE = 1;
    public static final int RUNNING = 2;
    public static final int TERMINATED = 3;
    private double s_time;
    private int s_state;

    protected Sched()
    {
        super(2);
        s_state = 1;
        s_time = 0.0D;
    }

    public void insert(double d)
    {        Sched sched = (Sched)Thread.currentThread();
        StaticSync.insert(sched, d);
    }

    public double get_clock()
    {
        return StaticSync.get_clock();
    }

    public void reset_clock()
    {
        StaticSync.reset_clock();    }    public void removerc()
    {
        Process process = (Process)this;
        StaticSync.removerc(process);
    }

    public double rdtime()
    {        return s_time;
    }

    public void set_time(double d)
    {
        s_time = d;
    }

    public int rdstate()
    {
        return s_state;
    }

    public void set_state(int i)
    {        s_state = i;
    }

    public void cancel(double d)
    {        Process process = (Process)this;
        if(s_state == 2)
        {            StaticSync.removerc(process);
        }
        s_state = 3;
        s_time = d;
    }

    public double result()
    {
        Thread thread = Thread.currentThread();
        Process process = (Process)StaticSync.this_process();
        if(process != (Pobject)thread)
        {
            Pobject.process_error(24);
        }
        if(s_state != 3)
        {
            process.deactivate(process);
        }
        return s_time;
    }
}
