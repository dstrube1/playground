package com.dstrube.samplesqllite

class Animal {
    private var id: Int = 0
    private var animalName: String? = null
    private var animalTallness: String? = null

    fun getId(): Int {
        return id
    }

    fun setId(id: Int) {
        this.id = id
    }

    fun getAnimalName(): String? {
        return animalName
    }

    fun setAnimalName(animalName: String) {
        this.animalName = animalName
    }

    fun getAnimalTallness(): String? {
        return animalTallness
    }

    fun setAnimalTallness(animalTallness: String) {
        this.animalTallness = animalTallness
    }

}