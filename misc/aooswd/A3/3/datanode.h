#include "node.h"
template <class T>
  class DataNode : public Node {
    T _data;

  public:
    DataNode(const T data, DataNode *right = 0) :
      Node(right), _data(data) {}
    DataNode(const DataNode &val) :
      Node(val), _data(val._data) {}

    const DataNode *right() const { 
      return((DataNode *) Node::right());
    }
    DataNode *&right() { return((DataNode *&) Node::right()); }

    const T &data() const { return _data; }
    T &data() { return _data; }

    DataNode &operator =(const DataNode &val) {
      Node::operator =(val);
      _data = val._data;
      return *this;
    }

    const int operator ==(const DataNode &val) const {
      return(
        Node::operator ==(val) &&
        _data == val._data);
    }
    const int operator !=(const DataNode &val) const {
      return !(*this == val);
    }
  };
