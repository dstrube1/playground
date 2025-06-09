// Node - container where objects in the linked list are stored
   class Node
   {
   public:
      Node( void *_pData )
      {
         pData = _pData;
         pNext = 0;
      } // end constructor
   
      Node *Next() { 
         return( pNext ); }
      void SetNext( Node *pNode ) { 
         pNext = pNode; }
      void *Data() { 
         return( pData ); }
   
   private:
      void *pData;
      Node *pNext;
   }; // end Node
