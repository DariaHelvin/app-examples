package com.fhhgb.healthhub.fragmentcalendar

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.AsyncListDiffer
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import com.fhhgb.healthhub.databinding.RecycleViewMedicineItemBinding
import com.fhhgb.healthhub.fragmentmedicine.MedicineViewHolder

class MedicineAdapter(private val onItemClick: (String) -> Unit) : RecyclerView.Adapter<MedicineViewHolder>() {
    val differ: AsyncListDiffer<String> = AsyncListDiffer(this, object : DiffUtil.ItemCallback<String>() {
        override fun areItemsTheSame(oldItem: String, newItem: String): Boolean {
            return oldItem == newItem
        }

        override fun areContentsTheSame(oldItem: String, newItem: String): Boolean {
            return oldItem == newItem
        }
    })

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MedicineViewHolder {
        val binding = RecycleViewMedicineItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return MedicineViewHolder(binding, onItemClick)
    }

    override fun getItemCount(): Int {
        return differ.currentList.size
    }

    override fun onBindViewHolder(holder: MedicineViewHolder, position: Int) {
        holder.setData(differ.currentList[position])
    }

    fun updateDataset(newData: List<String>) {
        differ.submitList(newData)
    }
}
