package com.fhhgb.healthhub.fragmentmedicine

import androidx.recyclerview.widget.RecyclerView.ViewHolder
import com.fhhgb.healthhub.databinding.RecycleViewMedicineItemBinding

class MedicineViewHolder(
    private val binding: RecycleViewMedicineItemBinding,
    private val onItemClick: (String) -> Unit
) : ViewHolder(binding.root) {
    fun setData(medicine: String) {
        binding.medicineItemDescription.text = medicine
        binding.root.setOnClickListener {
            onItemClick(medicine)
        }
    }
}
