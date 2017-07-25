package psimjava;

import java.io.PrintStream;

public class Pobject extends Thread
{

    public static final int MAX_PRIORITIES = 350;
    public static final int INT_COMM_TIMER = 350;
    public static final int OBJECT = 0;
    public static final int TASK = 2;
    public static final int QHEAD = 3;
    protected static long error_fct;
    private int p_priority;
    private int ao_type;
    protected Pobject o_next;
    private static int in_error = 0;
    private static String error_name[] = {
        "", "Object has chain", "object is on chain", "queue is empty", "object on other queue", "queue is full", "object on other queue", "queue is full", "clock not zero", "clock process not idle", 
        "process terminated", "process is running", "clock has neg time", "process or timer on other queue", "bad arguments for histogram", "stack overflow", "free store exhausted", "bad mode on creation", "process not terminated", "process not running", 
        "timer not terminated", "bad value of time", "bad object", "queue not empty", "process self result", "process wait for self", "number of req bin items", "number of created processes", "timing error", "number of req res items", 
        "number of released items", "number of running processes too big", "bad arguments", "number of priorities too big"
    };
    public static final int E_OLINK = 1;
    public static final int E_ONEXT = 2;
    public static final int E_GETEMPTY = 3;
    public static final int E_PUTOBJ = 4;
    public static final int E_PUTFULL = 5;
    public static final int E_BACKOBJ = 6;
    public static final int E_BACKFULL = 7;
    public static final int E_SETCLOCK = 8;
    public static final int E_CLOCKIDLE = 9;
    public static final int E_RESTERM = 10;    public static final int E_RESRUN = 11;
    public static final int E_NEGTIME = 12;
    public static final int E_RESOBJ = 13;
    public static final int E_HISTO = 14;    public static final int E_STACK = 15;
    public static final int E_STORE = 16;
    public static final int E_TASKMODE = 17;
    public static final int E_TASKDEL = 18;
    public static final int E_TASKPRE = 19;
    public static final int E_TIMERDEL = 20;
    public static final int E_SCHTIME = 21;
    public static final int E_SCHOBJ = 22;
    public static final int E_QDEL = 23;
    public static final int E_RESULT = 24;
    public static final int E_WAIT = 25;
    public static final int E_BINNRR = 26;
    public static final int E_PRNUMEX = 27;
    public static final int E_PRTIM = 28;
    public static final int E_RESRI = 29;
    public static final int E_RESREL = 30;
    public static final int E_PRRMX = 31;
    public static final int E_SIMARG = 32;
    public static final int E_WTQMPR = 33;
    public static final int MAXERR = 25;

    public Pobject(int i)
    {
        ao_type = i;
        o_next = null;
        p_priority = 0;
    }    public int o_type()
    {
        return ao_type;
    }    public static void print_error(int i)
    {
        System.out.println(" *** Process error " + i);
        System.out.println(error_name[i]);
    }    public static int process_error(int i)    {
        print_error(i);
        System.exit(i);
        in_error = 0;
        return 0;
    }    public void set_prio(int i)
    {
        p_priority = i;
    }

    public int get_prio()
    {
        return p_priority;
    }

}
