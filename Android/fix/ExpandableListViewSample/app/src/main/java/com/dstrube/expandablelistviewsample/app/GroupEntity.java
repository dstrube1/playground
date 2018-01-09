package com.dstrube.expandablelistviewsample.app;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by unbounded on 6/11/2014.
 */
public class GroupEntity {
    public String Name;
    public List<GroupItemEntity> GroupItemCollection;

    public GroupEntity()
    {
        GroupItemCollection = new ArrayList<GroupItemEntity>();
    }

    public class GroupItemEntity
    {
        public String Name;
    }

}
