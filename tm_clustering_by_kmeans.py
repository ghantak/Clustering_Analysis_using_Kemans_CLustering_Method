import mdtraj as md
import numpy as np
from sklearn.cluster import KMeans
from multiprocessing import Pool, cpu_count

def compute_rmsd_for_frame(args):
    """Compute RMSD of a specific frame against all other frames."""
    traj, frame_index = args
    return md.rmsd(traj, traj, frame=frame_index)

# Load trajectory and topology
traj = md.load('../../../../WT/dcd/Tm_nskip_50ps.dcd', top='../../../../WT/dcd/Tm.pdb')

# Compute the pairwise RMSD matrix in parallel
print("Computing pairwise RMSD matrix in parallel...")
n_frames = traj.n_frames
pairwise_rmsd = np.zeros((n_frames, n_frames))

with Pool(cpu_count()) as pool:
    results = pool.map(compute_rmsd_for_frame, [(traj, i) for i in range(n_frames)])

# Convert results into a symmetric pairwise RMSD matrix
pairwise_rmsd = np.array(results)
pairwise_rmsd = (pairwise_rmsd + pairwise_rmsd.T) / 2
np.fill_diagonal(pairwise_rmsd, 0)

# Convert RMSD matrix to feature vectors for k-means clustering
print("Preparing data for k-means clustering...")
feature_vectors = pairwise_rmsd

# Define the number of clusters (k)
n_clusters = 10  # Adjust based on your data
print(f"Performing k-means clustering with {n_clusters} clusters...")
kmeans = KMeans(n_clusters=n_clusters, random_state=42)
cluster_ids = kmeans.fit_predict(feature_vectors)

# Calculate the size and percentage of each cluster
total_frames = traj.n_frames
unique_clusters, cluster_sizes = np.unique(cluster_ids, return_counts=True)
percentages = (cluster_sizes / total_frames) * 100

# Find the representative frame for each cluster
def find_representative_frame(cluster_frames, pairwise_rmsd):
    """Find the representative frame with the smallest average RMSD in the cluster."""
    avg_rmsd = np.mean(pairwise_rmsd[cluster_frames][:, cluster_frames], axis=1)
    return cluster_frames[np.argmin(avg_rmsd)]

# Save cluster information and frame numbers to a file
output_file = "kmeans_cluster_results_tm.txt"
print(f"Saving clustering results to {output_file}...")
with open(output_file, "w") as f:
    f.write("Cluster Information:\n")
    for cluster_id, size, percentage in zip(unique_clusters, cluster_sizes, percentages):
        frames_in_cluster = np.where(cluster_ids == cluster_id)[0]
        representative_frame = find_representative_frame(frames_in_cluster, pairwise_rmsd)
        f.write(f"\nCluster {cluster_id + 1}:\n")
        f.write(f"Size = {size}, Percentage = {percentage:.2f}%\n")
        f.write(f"Frames = {', '.join(map(str, frames_in_cluster))}\n")
        f.write(f"Representative Frame = {representative_frame}\n")

print(f"Clustering results saved to {output_file}.")
