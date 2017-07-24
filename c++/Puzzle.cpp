#include <iostream>
#include <string>
#include <list>

   class Position
   {
   public:
   
    /**
     *  pre:    configin is a string of at least size characters which
     *          represents a valid configuration
     *  post:   Initialized to that configuration and empty list
     *          of moves.
     */
      Position(string configin);
   
    /*
     *  Display the pegs and holes configuration
     */
      void displayConfiguration();
   
    /*
     *  Display the sequence of moves needed to get to this
     *  position from the initial position.
     */
      void displayMoves();
   
    /**
     *  Returns a list of all possible next positions
     */
      list<Position> nextPositions();
   
   
    /**
     *  Return the number of pegs in the position
     */
      int numPegs();
   
      bool Done();
   
   private:
    //  configuration of holes and pegs
      string config;
      static const char hole = 'o';
      static const char peg = 'p';
   
    // size of the board
      int size;
   
   
    // List of moves to get to this position 
    // each move is represented by two consecutive integers,
    // the index from which a peg moves followed by the
    // index to which the peg moves.
      list<int> moves;
   
    /**
     *  pre:    A move in this position from from to to is valid
     *  post:   Returns the postion gotten by making that move.
     */
      void next(int from, int to);
   
   };





   int main(){
      string start;
      cout <<"Enter a starting position: ";
      cin>>start;
      Position p(start);
      cout<<"Heres the config: ";
      p.displayConfiguration();
      cout <<"and heres how many of the holes have pegs: "<<p.numPegs()<<endl;
      cout << "now the fun..."<<endl;
      while (!(p.Done())){
      //breadth 1st search
      //http://science.kennesaw.edu/~bsetzer/3100sp01/SourceCode/Fogle/Puzzle.cpp
      }
   	return 0;
   }



   Position::Position(string configin){
      config=configin;
      size=config.size();
   }


   void Position::displayConfiguration() {
      cout<< config<<endl;
   }

   void Position::displayMoves() {
      list<int>::iterator start, stop;
      start=moves.begin();
      stop=moves.end();
      cout<<"[";
      for (int i=0; start!=stop; i++){
         if ((i%2)==1)
            cout<<"("<<(*start)<<"->";
         else
            cout<<(*start)<<")";
         ++start;
      }
      cout<<"]"<<endl;
   
   }

/*
   void Position::displayLONP(){
      list<Position> P = nextPositions();
      list<Position>::iterator start, stop;
      start=P.begin();
      stop=P.end();
      cout<<"[";
      for (int i=0; start!=stop; i++){
         Position Q = *start;
         Q.displayConfiguration();
         ++start;
      }
      cout<<"]"<<endl;
      }
*/

   list<Position> Position::nextPositions() {
      list<Position> posibles;
   
      for (int i=0; i<size; i++){
         if ((config[i] == peg)&&(config[i] == config[i+1])&&(config[i+2] == hole)){ //PPO
            string copee1(config);
            copee1[i]=hole;
            copee1[i+1]=hole;
            copee1[i+2]=peg;
            Position posit (copee1);
            posibles.push_back(posit);
         }
         if ((config[i] == hole)&&(config[i+1] == config[i+2])&&(config[i+1] == peg)){ //OPP
            string copee2(config);
            copee2[i]=peg;
            copee2[i+1]=hole;
            copee2[i+2]=hole;
            Position posit (copee2);
            posibles.push_back(posit);
         }
      
      }
      return posibles;
   }


   int Position::numPegs() {
      int num = 0; //# of holes with pegs
   
      for (int i = 0; i<size; i++){
         if (config[i]==peg)
            num++;
      }   
      return num;   
   }


   void Position::next(int from, int to) {
   
      config.replace(to,1,peg);
      config.replace(from,1,hole);
      if (from<to)
         config.replace((to-1),1,hole);
      else
         config.replace((to+1),1,hole);
   }

   bool Position::Done(){
      bool anser;
      if (numPegs()>1){
         list <Position> test (nextPositions());
         bool testMT = test.empty();
         if (testMT)
            anser = false;
      
      }
      else 
         anser = true;
   
      return anser;
   }


