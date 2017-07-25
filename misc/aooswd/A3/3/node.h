   class Node {
      Node *right;
      Node *left;
   
   public:
      Node(Node *r = 0, Node *l = 0) {
         right(r);
         left(l);}
      Node(const Node &val) {
         right(val.right);
         left(val.left);}
   
      const Node rPtr() const { 
         return right; }
   
      const Node lPtr() const { 
         return left; }
   /////////////////////////////stopped changing here
   /*
      Node *&right() { 
         return _right; }
   
      Node &operator =(const Node &val) {
         _right = val._right;
         return *this;}
   
      const int operator ==(const Node &val) const {
         return _right == val._right;}
      const int operator !=(const Node &val) const {
         return !(*this == val);}
   		*/
   };
