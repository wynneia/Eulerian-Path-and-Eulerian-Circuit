class Graph
  attr_accessor :adj_list

  def initialize
    @adj_list = {}
  end

  def add_edge(u, v)
    @adj_list[u] ||= []
    @adj_list[v] ||= []
    @adj_list[u] << v
    @adj_list[v] << u
  end

  def remove_edge(u, v)
    @adj_list[u].delete(v)
    @adj_list[v].delete(u)
  end

  def eulerian_path
    start_vertex = find_start_vertex
    if start_vertex.nil?
      puts "No Eulerian path exists."
      return
    end
    path = []
    dfs(start_vertex, path)
    puts "Eulerian Path: #{path.join(' -> ')}"
  end

  def eulerian_circuit
    start_vertex = find_start_vertex
    if start_vertex.nil?
      puts "No Eulerian circuit exists."
      return
    end
    circuit = []
    dfs(start_vertex, circuit)
    puts "Eulerian Circuit: #{circuit.join(' -> ')}"
  end

  private

  def dfs(vertex, path)
    while !@adj_list[vertex].empty?
      neighbor = @adj_list[vertex].pop
      dfs(neighbor, path)
    end
    path << vertex
  end

  def find_start_vertex
    odd_vertices = @adj_list.select { |_, neighbors| neighbors.size.odd? }.keys
    if odd_vertices.size == 0
      # Eulerian Circuit
      return @adj_list.keys.first
    elsif odd_vertices.size == 2
      # Eulerian Path
      return odd_vertices.first
    else
      return nil
    end
  end
end

# Example usage:
graph = Graph.new
graph.add_edge(0, 1)
graph.add_edge(0, 2)
graph.add_edge(1, 2)
graph.add_edge(2, 3)
graph.add_edge(2, 4)
graph.add_edge(3, 4)
graph.add_edge(4, 5)

puts "Graph:"
graph.adj_list.each { |vertex, neighbors| puts "#{vertex}: #{neighbors.join(', ')}" }

puts "\nFinding Eulerian Path:"
graph.eulerian_path

puts "\nFinding Eulerian Circuit:"
graph.eulerian_circuit
