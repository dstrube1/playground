package com.dstrube.xmlparsingtest.model

import android.R.attr.description



class MenuItem {
    //Not to be confused with android.view.MenuItem

    private var id: String? = null
    private var name: String? = null
    private var cost: String? = null
    private var description: String? = null

    constructor () {
        println("Parameterless constructor for ${this.javaClass.name}")
        setId("")
        setName("")
        setCost("")
        setDescription("")
    }

    constructor(id: String, name: String, cost: String, description: String) {
        println("Parametered constructor for ${this.javaClass.name}")
        setId(id)
        setName(name)
        setCost(cost)
        setDescription(description)
    }

    fun getId(): String? {
        return id
    }

    fun getName(): String? {
        return name
    }

    fun getCost(): String? {
        return cost
    }

    fun getDescription(): String? {
        return description
    }

    fun setId(id: String) {
        this.id = id
    }

    fun setName(name: String) {
        this.name = name
    }

    fun setCost(cost: String) {
        this.cost = cost
    }

    fun setDescription(description: String) {
        this.description = description
    }

}