package com.fhhgb.healthhub.fragmentcalendar

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.AsyncListDiffer
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import com.fhhgb.healthhub.databinding.RecycleViewItemBinding

class VisitAdapter : RecyclerView.Adapter<VisitViewHolder>() {
    private val differ: AsyncListDiffer<Visit> = AsyncListDiffer(this, object : DiffUtil.ItemCallback<Visit>() {
        override fun areItemsTheSame(oldItem: Visit, newItem: Visit): Boolean {
            return oldItem == newItem
        }

        override fun areContentsTheSame(oldItem: Visit, newItem: Visit): Boolean {
            return oldItem == newItem
        }
    })
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): VisitViewHolder {
        return VisitViewHolder(
            RecycleViewItemBinding.inflate(LayoutInflater.from(parent.context),
                parent,
                false)
        )

    }

    override fun getItemCount(): Int {
        return differ.currentList.size
    }

    override fun onBindViewHolder(holder: VisitViewHolder, position: Int) {
        holder.setData(differ.currentList.get(position))
    }

    fun updateDataset (newDate:List<Visit>){
        differ.submitList(newDate)
    }


}