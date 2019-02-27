/*
 * This file is auto-generated.  DO NOT MODIFY.
 * Original file: /Users/dstrube/Projects/github/playground/Android/TestBinder/app/src/main/aidl/com/example/testbinder/IMultiplier.aidl
 */
package com.example.testbinder;
public interface IMultiplier extends android.os.IInterface
{
/** Local-side IPC implementation stub class. */
public static abstract class Stub extends android.os.Binder implements com.example.testbinder.IMultiplier
{
private static final java.lang.String DESCRIPTOR = "com.example.testbinder.IMultiplier";
/** Construct the stub at attach it to the interface. */
public Stub()
{
this.attachInterface(this, DESCRIPTOR);
}
/**
 * Cast an IBinder object into an com.example.testbinder.IMultiplier interface,
 * generating a proxy if needed.
 */
public static com.example.testbinder.IMultiplier asInterface(android.os.IBinder obj)
{
if ((obj==null)) {
return null;
}
android.os.IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
if (((iin!=null)&&(iin instanceof com.example.testbinder.IMultiplier))) {
return ((com.example.testbinder.IMultiplier)iin);
}
return new com.example.testbinder.IMultiplier.Stub.Proxy(obj);
}
@Override public android.os.IBinder asBinder()
{
return this;
}
@Override public boolean onTransact(int code, android.os.Parcel data, android.os.Parcel reply, int flags) throws android.os.RemoteException
{
java.lang.String descriptor = DESCRIPTOR;
switch (code)
{
case INTERFACE_TRANSACTION:
{
reply.writeString(descriptor);
return true;
}
case TRANSACTION_multiply:
{
data.enforceInterface(descriptor);
int _arg0;
_arg0 = data.readInt();
int _arg1;
_arg1 = data.readInt();
java.lang.String _result = this.multiply(_arg0, _arg1);
reply.writeNoException();
reply.writeString(_result);
return true;
}
default:
{
return super.onTransact(code, data, reply, flags);
}
}
}
private static class Proxy implements com.example.testbinder.IMultiplier
{
private android.os.IBinder mRemote;
Proxy(android.os.IBinder remote)
{
mRemote = remote;
}
@Override public android.os.IBinder asBinder()
{
return mRemote;
}
public java.lang.String getInterfaceDescriptor()
{
return DESCRIPTOR;
}
@Override public java.lang.String multiply(int a, int b) throws android.os.RemoteException
{
android.os.Parcel _data = android.os.Parcel.obtain();
android.os.Parcel _reply = android.os.Parcel.obtain();
java.lang.String _result;
try {
_data.writeInterfaceToken(DESCRIPTOR);
_data.writeInt(a);
_data.writeInt(b);
mRemote.transact(Stub.TRANSACTION_multiply, _data, _reply, 0);
_reply.readException();
_result = _reply.readString();
}
finally {
_reply.recycle();
_data.recycle();
}
return _result;
}
}
static final int TRANSACTION_multiply = (android.os.IBinder.FIRST_CALL_TRANSACTION + 0);
}
public java.lang.String multiply(int a, int b) throws android.os.RemoteException;
}
