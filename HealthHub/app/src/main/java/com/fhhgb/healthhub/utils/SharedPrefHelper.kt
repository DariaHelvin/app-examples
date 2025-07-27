package com.fhhgb.healthhub.utils

import android.content.Context
import android.content.SharedPreferences

class SharedPrefHelper(context: Context) {
    private val sharedPreferences: SharedPreferences =
        context.getSharedPreferences("HealthHubPrefs", Context.MODE_PRIVATE)

    fun saveMedicineList(medicineList: List<String>) {
        val editor = sharedPreferences.edit()
        editor.putStringSet("MedicineList", medicineList.toSet())
        editor.apply()
    }

    fun getMedicineList(): List<String> {
        return sharedPreferences.getStringSet("MedicineList", emptySet())?.toList() ?: emptyList()
    }
}
