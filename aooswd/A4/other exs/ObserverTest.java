
import java.awt.*;
import java.applet.Applet;
import java.util.Observer;
import java.util.Observable;


/** This class extends the Observable class by making
  two methods public.  This is necessary in order to 
  delegate observable behavior in the counter class */
class MyObservable extends Observable {
  
  public void clearChanged() {
    super.clearChanged();
  }

  public void setChanged() {
    super.setChanged();
  }

}

/** This is a counter class that delegates observable behavior
  to a containted MyObservable object.  A method is provided
  to access this obect. The counter object has a private integer
  variable to hold the counter value, a text field to display it,
  and a button to increment the value.  Note that since this Counter
  is a GUI widget, it inherits it's behavor from the AWT class Panel.
  Since we also want it to be observable, that behavior must be provided
  through delegation. */
class Counter extends Panel {
  Label countField;
  Button incButton;
  private int _count = 0;
  MyObservable _observable;

  public Counter() {
    setLayout(new BorderLayout());
    add("Center",countField = new Label("Count: 0"));
    add("South",incButton = new Button("Increment"));
    _observable = new MyObservable();
  }

  public int value() {
    return _count;
  }

  public Observable observable() {
    return _observable;
  }

  public boolean action(Event evt, Object arg) {
    if(evt.target == incButton) {
      _count++;
      countField.setText("Count: "+ _count);
      _observable.setChanged();
      _observable.notifyObservers(this);
      return true;
    }
    return false;
  }
  
}

/** This class provides a textual view of the counter,
   and is an observer of the counter */
class TextView extends TextField implements Observer {
  
  public TextView(Counter c) {
    super(10);
    setEditable(false);
    setText(String.valueOf(c.value()));
  }

  public void update(Observable o, Object counter) {
    setText(String.valueOf(((Counter)counter).value()));
  }

}

/** This class provides a scroll bar view of the counter value */
class ScrollView extends Scrollbar implements Observer {

  public ScrollView(Counter c) {
    super(Scrollbar.HORIZONTAL,0,1,0,10);
    setValue(c.value());
  }

  public void update(Observable o, Object counter) {
    setValue(((Counter)counter).value());
  }

}

/** A simple applet to show the Counter and its two
  Observers, a TextView and a ScrollView */
public class ObserverTest extends Applet {
  Counter c;
  TextView tv;
  ScrollView sv;

  public ObserverTest() {
    setLayout(new BorderLayout());
    add("North",c = new Counter());
    add("Center",tv = new TextView(c));
    add("South",sv = new ScrollView(c));
    c.observable().addObserver(tv);
    c.observable().addObserver(sv);

  }

}
