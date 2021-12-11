using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class testVertices : MonoBehaviour
{
    public MeshFilter m_mesh;
    public Collider m_collider;
    private void OnDrawGizmos()
    {
        Mesh mesh = m_mesh.mesh;
        Vector3[] vertices = mesh.vertices;
        for (var i = 0; i < vertices.Length; i++)
        {
            Vector3 current_point = GetVertexWorldPosition(vertices[i], m_mesh.transform);
            if (m_collider.bounds.Contains(current_point))
            {

                vertices[i] = GetLocalPosition(m_collider.ClosestPointOnBounds(new Vector3(current_point.x, current_point.y - 1f, current_point.z)), m_mesh.transform);//new Vector3(vertices[i].x, vertices[i].y - 0.1f, vertices[i].z);
                Gizmos.DrawSphere( GetVertexWorldPosition( vertices[i], m_mesh.transform), 0.01f);
            }
            else
            {
                Gizmos.DrawSphere(GetVertexWorldPosition(vertices[i], m_mesh.transform), 0.01f);
            }
            
        }

    }
    public Vector3 GetLocalPosition(Vector3 vertex, Transform owner)
    {
        return owner.worldToLocalMatrix.MultiplyPoint3x4(vertex);
    }
    public Vector3 GetVertexWorldPosition(Vector3 vertex, Transform owner)
    {
        
        return owner.localToWorldMatrix.MultiplyPoint3x4(vertex);
    }

    // Update is called once per frame
    void Update()
    {
        Mesh mesh = m_mesh.mesh;
        Vector3[] vertices = mesh.vertices;
        for (var i = 0; i < vertices.Length; i++)
        {
            Vector3 current_point = GetVertexWorldPosition(vertices[i], m_mesh.transform);
            if (m_collider.bounds.Contains(current_point))
            {
                vertices[i] = GetLocalPosition(m_collider.ClosestPointOnBounds(new Vector3(current_point.x, current_point.y - 1f, current_point.z)), m_mesh.transform);
            }

        }
        mesh.vertices = vertices;
    }
}
