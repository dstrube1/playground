/**
 * SWFAddress v1.1: Deep linking for Flash - http://www.asual.com/swfaddress/
 * 
 * SWFAddress is (c) 2006 Rostislav Hristov and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 *
 */

import flash.external.*;

_global.SWFAddress = function(){
    this._check = function() {
        if (SWFAddress.onChange) {
            clearInterval(this._interval);
            if (this._availability) {
                ExternalInterface.addCallback('getSWFAddressValue', this, 
                    function(){return SWFAddress._value});
                ExternalInterface.addCallback('setSWFAddressValue', this, 
                    SWFAddress.setValue);
            }
            SWFAddress.setValue(SWFAddress.getValue());
        }
    }
    this._availability = ExternalInterface.available;    
    this._interval = setInterval(this, '_check', 10);
    this._value = '';
}
_global.SWFAddress = new SWFAddress();

SWFAddress.getTitle = function() {
    var title = (this._availability) ? 
        String(ExternalInterface.call('SWFAddress.getTitle')) : '';
    if (title == 'undefined' || title == 'null') title = '';
    return title;
}

SWFAddress.setTitle = function(title) {
    if (this._availability) ExternalInterface.call('SWFAddress.setTitle', title);
}

SWFAddress.getStatus = function() {
    var status = (this._availability) ? 
        String(ExternalInterface.call('SWFAddress.getStatus')) : '';
    if (status == 'undefined' || status == 'null') status = '';
    return status;
}

SWFAddress.setStatus = function(status) {
    if (this._availability) ExternalInterface.call('SWFAddress.setStatus', status);
}

SWFAddress.resetStatus = function() {
    if (this._availability) ExternalInterface.call('SWFAddress.resetStatus');
}

SWFAddress.getPath = function() {
    var uri = SWFAddress.getValue();
    if (uri.indexOf('?') != 1) {
        return uri.split('?')[0];
    } else {
        return uri;   
    }
}

SWFAddress.getQueryString = function() {
    var value = SWFAddress.getValue();
    var index = path.indexOf('?');
    if (index != -1 && index < value.length) {
        return value.substr(index + 1);
    }
    return '';
}

SWFAddress.getParameter = function(param) {
    var value = SWFAddress.getValue();
    var index = value.indexOf('?');
    if (index != -1) {
        value = value.substr(index + 1);
        var params = value.split('&');
        var p, i = params.length;
        while(i--) {
            p = params[i].split('=');
            if (p[0] == param) {
                return p[1];
            }
        }
    }
    return '';
}

SWFAddress.getParameterNames = function() {
    var value = SWFAddress.getValue();
    var index = value.indexOf('?');
    var names = new Array();
    if (index != -1) {
        value = value.substr(index + 1);
        if (value != '' && value.indexOf('=') != -1) {            
            var params = value.split('&');
            var i = 0;
            while(i < params.length) {
                names.push(params[i].split('=')[0]);
                i++;
            }
        }
    }
    return names;
}

SWFAddress.getValue = function() {
    var addr, id = 'null';
    if (this._availability) {
       addr = String(ExternalInterface.call('SWFAddress.getValue'));
       id = String(ExternalInterface.call('SWFAddress.getId'));
    }
    if (id == 'null' || !this._availability) {
        addr = SWFAddress._value;        
    } else {
        if (addr == 'undefined' || addr == 'null') addr = '';
    }
    return addr;
}

SWFAddress.setValue = function(addr) {
    if (addr == 'undefined' || addr == 'null') addr = '';
    SWFAddress._value = addr;
    if (this._availability) ExternalInterface.call('SWFAddress.setValue', addr);
    if (SWFAddress.onChange) SWFAddress.onChange();
}